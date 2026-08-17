const cookieDomain =
  document.location.hostname === "localhost"
    ? "localhost"
    : "citizensadvice.org.uk";

export default function initCookiePreferencesPage() {
  const formContainer = document.getElementById("js-enabled-cookie-form");
  if (formContainer) {
    formContainer.hidden = false;
    formContainer.removeAttribute("aria-hidden");

    // There is a bug where if we reject previously accepted _ga cookies via the form,
    // the _ga_<container-id> cookie is re-added on the next page load, even though the ga script is not
    // Once the user submits the form, it refreshes the same page - the aim of the script is to execute after that refresh
    // It checks if the analytics radio button is not accepted, and if that's the case if the analytics cookie is still there
    // In those cases, similarly to the cookie banner, we want to expire the cookie and to switch off analytics
    const analyticsInput = document.getElementById(
      "cookie_preference_analytics_true",
    );

    if (!analyticsInput.checked) {
      document.cookie
        .split(";")
        .map((cookie) => cookie.trim())
        .filter(Boolean) // Remove empty strings
        .forEach((cookieString) => {
          // Split name from value safely
          const cookieName = cookieString.split("=")[0];
          removeGaCookie(cookieName);
        });
    }
  }
}

function removeGaCookie(cookieName, value = "") {
  // Stops _ga_<container-id> cookies from appearing when the user rejects cookies and navigates to a differnt page
  if (cookieName.startsWith("_ga") && cookieName != "_ga") {
    let thePast = new Date(0).toUTCString(); // 0 = 0 seconds since UTC started (1970/01/01)
    // We need to remove the ga cookie if it's available
    document.cookie = `${cookieName}=${value};expires=${thePast};path=/;`;
    document.cookie = `${cookieName}=${value};expires=${thePast};domain=${cookieDomain};path=/;`;

    const gaId = cookieName.slice(4);
    // Force GA to stop sending data
    window[`ga-disable-G-${gaId}`] = true;
  }
}
