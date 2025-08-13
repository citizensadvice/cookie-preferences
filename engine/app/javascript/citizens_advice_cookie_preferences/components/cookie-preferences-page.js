function addCookiePreferencePageEventHandler() {
  const form = document.querySelector(".edit_cookie_preference");
  const submitButton = form?.querySelector("button");

  if (form && submitButton) {
    submitButton.addEventListener("click", (e) => {
      e.preventDefault();
      // some code goes here
      console.log("This is test from a differet file");
      form.submit();
    });
  }
}

export default function initCookiePreferencesPage() {
  addCookiePreferencePageEventHandler();
}
