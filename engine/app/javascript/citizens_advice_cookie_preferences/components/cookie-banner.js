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

const DEFAULT_COOKIE_CONSENT = {
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
  setCookie("cookie_preference_set", true, 365);
  showConfirmationMessage();
  document.querySelector(selectors.confirmationMessageAccept).hidden = false;
};

const rejectCookies = () => {
  setCookie(
    "cookie_preference",
    encodeURIComponent(JSON.stringify(DEFAULT_COOKIE_CONSENT)),
    365,
  );
  setCookie("cookie_preference_set", true, 365);
  showConfirmationMessage();
  document.querySelector(selectors.confirmationMessageReject).hidden = false;
};

function hideCookieBanner() {
  const cookieBanner = document.querySelector(selectors.cookieBanner);
  cookieBanner.hidden = true;
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

function loadAnalytics() {
  if (!window.gaGlobal) {
    // Load gtm script
    // Script based on snippet at https://developers.google.com/tag-manager/quickstart
    // prettier-ignore
    ;(function (w, d, s, l, i) {
      w[l] = w[l] || []
      w[l].push({
        'gtm.start': new Date().getTime(),
        event: 'gtm.js'
      })

      const j = d.createElement(s)
      const dl = l !== 'dataLayer' ? `&l=${l}` : ''

      var csp_nonce = document.getElementsByName('csp-nonce')[0].getAttribute('content');
      j.async = true
      j.src = `https://www.googletagmanager.com/gtm.js?id=${i}${dl}`
      j.setAttribute('nonce',csp_nonce)
      document.head.appendChild(j)
    })(window, document, 'script', 'dataLayer', 'GTM-T5MB575')
  }
}

function acceptCookiesGTMEvent () {
  window.dataLayer.push({
    event: 'acceptAllCookies',
  });
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
    loadAnalytics();
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
  setDefaultCookies();
  addCookieBannerEventHandlers();
}

// need to add gtm classes to button in view, depending on cookie acceptance status

// need datalayer push for accept & reject cookies

// make confirmation banner accessible - e.g. focus or live region?
