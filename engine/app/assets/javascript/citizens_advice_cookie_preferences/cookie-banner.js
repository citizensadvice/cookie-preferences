const cookieBanner = document.querySelector(".js-cookie-banner");
const acceptBtn = document.querySelector("#js-cookie-banner__button-accept");
const rejectBtn = document.querySelector("#js-cookie-banner__button-reject");
const cookieSelectionContainer = document.querySelector(".js-cookie-banner__selection-container");
const confirmationMessageContainer = document.querySelector(".js-cookie-banner__confirmation-message");
const confirmationMessageAccept = confirmationMessageContainer.querySelector(".js-cookie-banner__confirmation-accept");
const confirmationMessageReject = confirmationMessageContainer.querySelector(".js-cookie-banner__confirmation-reject");
const hideBannerBtn = confirmationMessageContainer.querySelector("#js-cookie-banner__button-hide");

function setCookie(cname, cvalue, exdays) {
  // set expiry date in milliseconds
  const d = new Date();
  d.setTime(d.getTime() + (exdays*24*60*60*1000));
  let expires = "expires="+ d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(name) {
  const nameEQ = `${name}=`
  const cookies = document.cookie.split(';')
  for (let i = 0, len = cookies.length; i < len; i++) {
    let cookie = cookies[i]
    while (cookie.charAt(0) === ' ') {
      cookie = cookie.substring(1, cookie.length)
    }
    if (cookie.indexOf(nameEQ) === 0) {
      return decodeURIComponent(cookie.substring(nameEQ.length))
    }
  }
  return null
}

const acceptCookies = () => {
  setCookie('cookie_preference', encodeURIComponent(JSON.stringify({
    essential: true,
    additional: true
  })), 365);
  setCookie('cookie_preference_set', true, 365);
  showConfirmationMessage();
  confirmationMessageAccept.hidden = false;
}

const rejectCookies = () => {
  setCookie('cookie_preference', encodeURIComponent(JSON.stringify(DEFAULT_COOKIE_CONSENT)), 365);
  setCookie('cookie_preference_set', true, 365);
  showConfirmationMessage();
  confirmationMessageReject.hidden = false;
}

const DEFAULT_COOKIE_CONSENT = {
  essential: true,
  additional: false
}

function hideCookieBanner() {
  cookieBanner.hidden = true;
}

function showConfirmationMessage() {
  cookieSelectionContainer.hidden = true;
  confirmationMessageContainer.hidden = false;
  confirmationMessageContainer.focus();
}

if(getCookie('cookie_preference_set')){
  hideCookieBanner();
}else{
  setCookie('cookie_preference', encodeURIComponent(JSON.stringify(DEFAULT_COOKIE_CONSENT)), 365);
}

acceptBtn.addEventListener("click", () => {
  acceptCookies();
});

rejectBtn.addEventListener("click", () => {
  rejectCookies();
});

hideBannerBtn.addEventListener("click", () => {
  hideCookieBanner();
});

console.log("using the new JS");

// need to add gtm classes to button in view, depending on cookie acceptance status

// need datalayer push for accept & reject cookies

// make confirmation banner accessible - e.g. focus or live region?