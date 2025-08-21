export default function initCookiePreferencesPage() {
  const formContainer = document.getElementById("js-enabled-cookie-form");
  if (formContainer) {
    formContainer.hidden = false;
    formContainer.removeAttribute("aria-hidden");
  }
}
