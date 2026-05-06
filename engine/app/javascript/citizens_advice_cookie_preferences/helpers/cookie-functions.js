const cookieDomain =
  document.location.hostname === "localhost"
    ? "localhost"
    : "citizensadvice.org.uk";

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