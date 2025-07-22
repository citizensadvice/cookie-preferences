import { beforeEach, expect, test } from 'vitest'
import { page } from '@vitest/browser/context'
import initCookieBanner from './cookie-banner'

// TODO: this is a placeholder test
function sum(a, b) {
    return a + b
}
test('adds 1 + 2 to equal 3', () => {
    expect(sum(1, 2)).toBe(3)
})

// actual tests start here

const componentHtml = `<div 
  class="cookie-banner js-cookie-banner" data-testid="test-id-cookie-banner">
  <div class="cads-grid-container">
    <div class="cads-grid-row">
      <div class="cads-grid-col-md-12 cads-grid-col-lg-8">
        <div class="cads-prose">
          <div class="cookie-banner__selection-container js-cookie-banner__selection-container">
            <h2>Cookies on Citizens Advice</h2>
            <p>We use essential cookies to make our website work properly.</p>
            <p>We'd also like to use additional cookies to remember your settings and to understand how you use our website. This helps us improve our services for you.</p>
            <p>Some additional cookies come from other websites. These cookies help us show you things from those websites, like videos.</p>
            <div class="cookie-banner__button-link-container">
              <div class="cookie-banner__button-container">
                <button id="js-cookie-banner__button-accept" class="cads-button cads-button__primary" type="button">Accept additional cookies</button>
                <button id="js-cookie-banner__button-reject" class="cads-button cads-button__primary" type="button">Reject additional cookies</button>
              </div>
              <a class="cookie-banner__link cads-paragraph" href="/cookie-preferences/cookie_preference/">Manage cookies</a>
            </div>
          </div>
          <div class="cookie-banner__confirmation-message js-cookie-banner__confirmation-message" tabindex="-1" hidden>
            <p class="cookie-banner__confirmation-message-text js-cookie-banner__confirmation-accept" data-testid="cookie-confirmation-accept" hidden="true">You’ve accepted additional cookies. You can 
            <a href="/cookie-preferences/cookie_preference/">change your cookie settings</a>
            at any time</p>
            <p class="cookie-banner__confirmation-message-text js-cookie-banner__confirmation-reject" data-testid="cookie-confirmation-reject" hidden="true">You’ve rejected additional cookies. You can
            <a href="/cookie-preferences/cookie_preference/">change your cookie settings</a>
            at any time</p>
            <button id="js-cookie-banner__button-hide" class="cads-button cads-button__primary" type="button">Hide this message</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>`

const DEFAULT_COOKIE_CONSENT = {
  essential: true,
  additional: false
}

const cookieBanner = page.getByTestId('test-id-cookie-banner')
const cookieBannerConfirmationAccept = page.getByTestId('cookie-confirmation-accept')
const cookieBannerConfirmationReject = page.getByTestId('cookie-confirmation-reject')

test('shows the cookie banner', async () => {
  document.body.innerHTML = componentHtml;
  initCookieBanner();

  await expect.element(cookieBanner).toBeVisible()
  await expect.element(cookieBannerConfirmationAccept).not.toBeVisible()
  await expect.element(cookieBannerConfirmationReject).not.toBeVisible()
})

// test('shows the cookie banner when preferences have not been actively set', async () => {
//
//   // Set default cookies, which are set whether there is any interaction or not.
//   setCookie('cookie_preference', encodeURIComponent(JSON.stringify(DEFAULT_COOKIE_CONSENT)), 365);
//
//   document.body.innerHTML = componentHtml;
//   initCookieBanner();
//
//   await expect.element(cookieBanner).toBeVisible()
//   await expect.element(cookieBannerConfirmationAccept).not.toBeVisible()
//   await expect.element(cookieBannerConfirmationReject).not.toBeVisible()
// })

// test('hides the cookie banner when preferences have been actively set', async () => {
//
// // TODO: need to be able to reinitialize the cookie banner to take account of the updated cookie position. Don't have an init method. Tried to add one, but broke banner.
//   setCookie('cookie_preference_set', true, 365);
//   document.body.innerHTML = componentHtml;
//   initCookieBanner();
//
//   await expect.element(cookieBanner).not.toBeVisible()
// })

// function setCookie(cname, cvalue, exdays) {
//   // set expiry date in milliseconds
//   const d = new Date();
//   d.setTime(d.getTime() + (exdays*24*60*60*1000));
//   let expires = "expires="+ d.toUTCString();
//   document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
// }