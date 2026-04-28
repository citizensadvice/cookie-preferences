import { COOKIE_CATEGORIES } from "../constants/cookie-categories";

const cookieDomain =
  document.location.hostname === "localhost"
    ? "localhost"
    : "citizensadvice.org.uk";

const consentedCategories = () => {
  const cookiePreference = JSON.parse(getCookie("cookie_preference"));
  return Object.keys(cookiePreference).filter(
    (key) => cookiePreference[key] === true,
  );
};

function permittedCookie(cookie) {
  let consented = consentedCategories();

  if (Object.prototype.hasOwnProperty.call(COOKIE_CATEGORIES, cookie)) {
    return consented.includes(COOKIE_CATEGORIES[cookie]);
  }

  // Wildcard cookies
  const wildcardMatch = Object.keys(COOKIE_CATEGORIES).find((key) => {
    return key.endsWith("*") && cookie.startsWith(key.slice(0, -1));
  });

  if (wildcardMatch) {
    const category = COOKIE_CATEGORIES[wildcardMatch];
    return consented.includes(category);
  }

  return false;
}

function expireCookie(cookie, value = "") {
  // We need to handle deleting cookies on the domain and the .domain
  let thePast = new Date(0); // 0 = 0 seconds since UTC started (1970/01/01)
  document.cookie = cookie + "=" + value + ";expires=" + thePast + ";";
  document.cookie =
    cookie +
    "=" +
    value +
    ";expires=" +
    thePast +
    `;domain=${cookieDomain};path=/`;
}

export function deleteUnconsentedCookies() {
  // We can only access and expire same domain cookies
  document.cookie
    .split(";")
    .map((cookie) => cookie.trim())
    .filter(Boolean) // Remove empty strings
    .forEach((cookieString) => {
      // Split name from value safely
      const cookieName = cookieString.split("=")[0];

      if (!permittedCookie(cookieName)) {
        expireCookie(cookieName);
      }
    });
}

export function setCookie(cname, cvalue, exdays) {
  // set expiry date in milliseconds
  const d = new Date();
  d.setTime(d.getTime() + exdays * 24 * 60 * 60 * 1000);
  let expires = "expires=" + d.toUTCString();
  document.cookie =
    cname +
    "=" +
    cvalue +
    ";" +
    expires +
    ";path=/" +
    `;domain=${cookieDomain}`;
}

export function getCookie(name) {
  const nameEQ = `${name}=`;
  const cookies = document.cookie.split(";");
  for (let i = 0, len = cookies.length; i < len; i++) {
    let cookie = cookies[i];
    while (cookie.charAt(0) === " ") {
      cookie = cookie.substring(1, cookie.length);
    }
    if (cookie.indexOf(nameEQ) === 0) {
      return decodeURIComponent(cookie.substring(nameEQ.length));
    }
  }
  return null;
}
