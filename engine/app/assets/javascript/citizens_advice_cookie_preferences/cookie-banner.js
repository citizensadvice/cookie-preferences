const cookieBanner = document.querySelector(".js-cookie-banner");
const acceptBtn = document.getElementById("accept");
const rejectBtn = document.getElementById("reject");
const cookieSelectionContainer = document.querySelector(".js-cookie-banner__selection-container");
const confirmationMessageContainer = document.querySelector(".js-cookie-banner__confirmation-message");
const confirmationMessageAccept = confirmationMessageContainer.querySelector(".js-cookie-banner__confirmation-accept");
const confirmationMessageReject = confirmationMessageContainer.querySelector(".js-cookie-banner__confirmation-reject");
const hideBannerBtn = confirmationMessageContainer.querySelector("button");


// Nice console.log to help show when js is being found
console.log("Hello outside init method!!");

function setCookie(cname, cvalue, exdays) {
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

// ** need to check expiry time for cookies
const acceptCookies = () => {
  setCookie('cookie_preference', JSON.stringify({
    essential_cookies: true,
    additional_cookies: true
  }), 365);
  setCookie('cookie_preference_set', true, 365);
  // set JS class that will display confirmation banner
  cookieSelectionContainer.classList.add('is-hidden');
  confirmationMessageContainer.classList.add('is-visible');
  confirmationMessageAccept.classList.add('is-visible');
}

const rejectCookies = () => {
  setCookie('cookie_preference', JSON.stringify({
    essential_cookies: true,
    additional_cookies: false
  }), 365);
  setCookie('cookie_preference_set', true, 365);
  // set JS class that will display confirmation banner
  cookieSelectionContainer.classList.add('is-hidden');
  confirmationMessageContainer.classList.add('is-visible');
  confirmationMessageReject.classList.add('is-visible');
}

const DEFAULT_COOKIE_CONSENT = {
  essential_cookies: true,
  additional_cookies: false
}

function hideCookieBanner() {
  cookieBanner.classList.add("is-hidden");
}

// set default cookie or hide cookie banner
if(getCookie('cookie_preference_set')){
  // set JS class that will mean that banner doesn't render or hideCookieBanner?
  hideCookieBanner();
}else{
  setCookie('cookie_preference', JSON.stringify(DEFAULT_COOKIE_CONSENT), 365);
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

// need to add gtm classes to button in view, depending on cookie acceptance status

// need datalayer push for accept & reject cookies

// need to render confirmation banner or rejection banner once button clicked (and to hide original banner).

// need event handler to close confirmation/rejection banner on 'hide this message' click

// need to render banner or not, depending on whether cookie preference has already been set

