export default function initCookiePreferencesPage() {
  const form = document.querySelector('.cookie-preferences-form');
  const submitButton = form.querySelector('button')
}

// add an event listener on the click
// do a console log
// aim is to stop the default rails behaviour on the click, do what we want, then continue with the rails submit behaviour
// MY expects it to work up until us adding analytics work, but doesn't know if the form.submit will now work properly or not.
// put it all in init function above. Could even put it all in the cookie-banner file for testing purposes, then move it out later if it works.