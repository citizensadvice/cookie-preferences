import { acceptCookiesGTMEvent } from "../helpers/analytics";

const selectors = {
  cookieBanner: ".js-cookie-banner",
  acceptBtn: "#js-cookie-banner__button-accept",
  rejectBtn: "#js-cookie-banner__button-reject",
  cookieSelectionContainer: ".js-cookie-banner__selection-container",
  confirmationMessageContainer: ".js-cookie-banner__confirmation-message",
  confirmationMessageAccept: ".js-cookie-banner__confirmation-accept",
  confirmationMessageReject: ".js-cookie-banner__confirmation-reject",
  hideBannerBtn: "#js-cookie-banner__button-hide",
};

const COOKIE_CATEGORIES = {
  _smart_meter_tool_session: "essential",
  _demo_session: "essential",
  _content_platform_forms_session: "essential",
  _energy_apps_session: "essential",
  cookie_preference: "essential",
  cookie_preference_set: "essential",
  _dd_s: "essential",
  _forms_key: "essential",
  _grecaptcha: "essential",
  activeChat: "essential",
  "amazon-connect-*": "essential",
  "amazon-connect-session-*": "essential",
  "cobrowse-storage_expiration-22834971": "essential",
  CustomizationObject: "essential",
  cwr_s: "essential",
  cwr_u: "essential",
  "lpLastVisit-*": "essential",
  lpPmCalleeDfs: "essential",
  "LPSID-*": "essential",
  lpTabId: "essential",
  LPVID: "essential",
  persistedChatSession: "essential",
  "X-Source": "essential",
  _ga: "analytics",
  "_ga_*": "analytics",
  ar_debug: "analytics",
  ethnio_displayed: "analytics",
  geo: "analytics",
  "mf_*": "analytics",
  mf_initialDomQueue: "analytics",
  mf_transmitQueue: "analytics",
  mf_user: "analytics",
  mouseflow: "analytics",
  "ca_ab_*": "analytics",
  __TAG_ASSISTANT: "analytics",
};

const DEFAULT_COOKIE_CONSENT = {
  essential: true,
  analytics: true,
  video_players: false,
};

const ESSENTIAL_COOKIE_CONSENT = {
  essential: true,
  analytics: false,
  video_players: false,
};

const cookieDomain =
  document.location.hostname === "localhost"
    ? "localhost"
    : "citizensadvice.org.uk";

function setCookie(cname, cvalue, exdays) {
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

function getCookie(name) {
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

const acceptCookies = () => {
  setCookie(
    "cookie_preference",
    encodeURIComponent(
      JSON.stringify({
        essential: true,
        analytics: true,
        video_players: true,
      }),
    ),
    365,
  );

  var cookie_current_version = document
    .getElementsByClassName("js-cookie-banner")[0]
    .getAttribute("data-cookie-current-version");
  setCookie("cookie_preference_set", cookie_current_version, 365);
  showConfirmationMessage();
  document.querySelector(selectors.confirmationMessageAccept).hidden = false;
};

const rejectCookies = () => {
  deleteUnconsentedCookies();

  setCookie(
    "cookie_preference",
    encodeURIComponent(JSON.stringify(ESSENTIAL_COOKIE_CONSENT)),
    365,
  );

  var cookie_current_version = document
    .getElementsByClassName("js-cookie-banner")[0]
    .getAttribute("data-cookie-current-version");
  setCookie("cookie_preference_set", cookie_current_version, 365);
  showConfirmationMessage();
  document.querySelector(selectors.confirmationMessageReject).hidden = false;
};

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

const consentedCategories = () => {
  const cookiePreference = JSON.parse(getCookie("cookie_preference"));
  return Object.keys(cookiePreference).filter(
    (key) => cookiePreference[key] === true,
  );
};

function permittedCookie(cookie) {
  let consented = consentedCategories();

  if (COOKIE_CATEGORIES.hasOwnProperty(cookie)) {
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

function deleteUnconsentedCookies() {
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

function hideCookieBanner() {
  const cookieBanner = document.querySelector(selectors.cookieBanner);
  if (cookieBanner) {
    cookieBanner.hidden = true;
  }
}

function showConfirmationMessage() {
  const cookieBanner = document.querySelector(selectors.cookieBanner);

  const confirmationMessageContainer = document.querySelector(
    selectors.confirmationMessageContainer,
  );
  document.querySelector(selectors.cookieSelectionContainer).hidden = true;
  confirmationMessageContainer.hidden = false;
  confirmationMessageContainer.focus();
  cookieBanner.classList.add("cookie-banner--no-decoration");
}

function setDefaultCookies() {
  if (getCookie("cookie_preference_set")) {
    hideCookieBanner();
  } else {
    const cookieBanner = document.querySelector(selectors.cookieBanner);
    cookieBanner.hidden = false;
    cookieBanner.removeAttribute("aria-hidden");
    setCookie(
      "cookie_preference",
      encodeURIComponent(JSON.stringify(DEFAULT_COOKIE_CONSENT)),
      365,
    );
  }
}

function addCookieBannerEventHandlers() {
  document.querySelector(selectors.acceptBtn).addEventListener("click", () => {
    acceptCookies();
    acceptCookiesGTMEvent();
  });

  document.querySelector(selectors.rejectBtn).addEventListener("click", () => {
    rejectCookies();
  });

  document
    .querySelector(selectors.hideBannerBtn)
    .addEventListener("click", () => {
      hideCookieBanner();
    });
}

export default function initCookieBanner() {
  const cookieBanner = document.querySelector(selectors.cookieBanner);

  if (cookieBanner) {
    setDefaultCookies();
    addCookieBannerEventHandlers();
  }
}
