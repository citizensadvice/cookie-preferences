import {loadAnalytics, setCookiePreferenceDlv, acceptCookiesGTMEvent} from "../helpers/analytics";

function addCookiePreferencePageEventHandler() {
  const form = document.querySelector(".edit_cookie_preference");
  const submitButton = form?.querySelector("button");

  console.log("form?", form);
  console.log("submit button?", submitButton);

  if (form && submitButton) {
    console.log("inside the form & submitButton if statement");
    console.log("submit button?", submitButton);
    const analyticsRadioButton = form?.querySelector("#cookie_preference_analytics_true");

    // TODO - we need to have a check if the analytics radio button is checked
    submitButton.addEventListener("click", (e) => {
      console.log("in the submit event listener before the prevent default")
      e.preventDefault();
      // some code goes here
      // Only accept cookies event when the analytics cookies are on!
      // if (analyticsRadioButton.checked) {
      //   loadAnalytics();
      //   acceptCookiesGTMEvent();
      //   setCookiePreferenceDlv();
      // }
      console.log("in the submit event listener")
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