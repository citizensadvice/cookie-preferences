/**
 * @vitest-environment jsdom
 */
import '@testing-library/jest-dom';
import { screen } from '@testing-library/dom';
import userEvent from '@testing-library/user-event';

import initCookieBanner, {setCookie} from "./cookie-banner";

describe('cookieBanner', () => {
    let setCookieSpy;
    beforeEach(async () => {
        const componentHtml = `<div class="cookie-banner js-cookie-banner" data-testid="cookie-banner">
    <div class="cads-grid-container">
      <div class="cads-grid-row">
         <div class="cads-grid-col-md-12 cads-grid-col-lg-8">
           <div class="cads-prose">
             <div class="cookie-banner__selection-container js-cookie-banner__selection-container">
               <h2>Cookies on Citizens Advice</h2>
               <p>We use essential cookies to make our website work properly.</p> <p>We'd also like to use additional cookies to remember your settings and to understand how you use our website. This helps us improve our services for you.</p> <p>Some additional cookies come from other websites. These cookies help us show you things from those websites, like videos.</p>
               <div class="cookie-banner__button-link-container">
                 <div class="cookie-banner__button-container">
                 <button class="cads-button cads-button__primary" type="button" id="js-cookie-banner__button-accept" data-testid="someid">
                      Accept additional cookies
                   </button>
                 <button class="cads-button cads-button__primary" type="button" id="js-cookie-banner__button-reject">
                      Reject additional cookies
                   </button>
                 </div>
                 <a class="cookie-banner__link cads-paragraph" href="/cookie-preferences/cookie_preference/">Manage cookies</a>
               </div>
             </div>
             <div class="cookie-banner__confirmation-message js-cookie-banner__confirmation-message" data-testid="cookie-banner-confirmation-message" tabindex="-1" hidden="">
               <p class="cookie-banner__confirmation-message-text js-cookie-banner__confirmation-accept" hidden="">
                   You've accepted additional cookies. You can <a href="/cookie-preferences/cookie_preference/">change your cookie settings</a> at any time
               </p>
               <p class="cookie-banner__confirmation-message-text js-cookie-banner__confirmation-reject" hidden="">
                   You've rejected additional cookies. You can <a href="/cookie-preferences/cookie_preference/">change your cookie settings</a> at any time
               </p>
               <button class="cads-button cads-button__primary" type="button" id="js-cookie-banner__button-hide">
                 Hide this message
               </button>
             </div>
           </div>
         </div>
       </div>
     </div>
   </div>`;

        document.body.innerHTML = componentHtml;

        initCookieBanner();

        vi.restoreAllMocks();

        setCookieSpy = vi.fn();
        Object.defineProperty(document, 'cookie', {
            configurable: true,
            get: vi.fn(() => ''),
            set: setCookieSpy
        })
    });

    afterEach(()=>{
        document.body.innerHTML = "";
    });

    it('test', async () => {
        const user = userEvent.setup();
        await user.click(screen.getByRole('button', { name: /Accept additional cookies/i }));
        console.log(document.cookie);
        console.log(setCookieSpy.mock.calls[0,0], 'cookie spy');
        expect(setCookieSpy).toHaveBeenCalledTimes(2);
    });
});
