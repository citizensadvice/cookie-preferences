import { loadAnalytics, setCookiePreferenceDlv, acceptCookiesGTMEvent } from "../helpers/analytics";

function addCookiePreferencePageEventHandler() {
  const form = document.querySelector(".edit_cookie_preference");
  const submitButton = form?.querySelector("button");


  if (form && submitButton) {
    const analyticsRadioButton = form?.querySelector("#cookie_preference_analytics_true");

    // TODO - we need to have a check if the analytics radio button is checked
    submitButton.addEventListener("click", (e) => {
      e.preventDefault();
      // some code goes here
      // Only accept cookies event when the analytics cookies are on!
      loadAnalytics();
      acceptCookiesGTMEvent();
      setCookiePreferenceDlv();
      form.submit();
    });
  }
}

export default function initCookiePreferencesPage() {
  addCookiePreferencePageEventHandler();
}

// TODO: remove the _ga cookies if analytics cookies are rejected