const acceptBtn = document.getElementById("accept");
const rejectBtn = document.getElementById("reject");
const hideBannerBtn = document.getElementById("hide-banner");

// ** Tried exporting an init const then pulling it into public-website. Didn't seem to work, but not sure whether it was because we were importing a const from outside the public-website repo.
const initTestCookie = () => {
  console.log("Hello!!");
};

// ** Nice console.log to help show when js is being found
console.log("Hello outside init method!!");

// ** commented out the messy code I'd started building to handle the accept & reject clicks, in case it was interfering with exporting the init const.

// function setCookie(cname, cvalue, exdays) {
//   const d = new Date();
//   d.setTime(d.getTime() + (exdays*24*60*60*1000));
//   let expires = "expires="+ d.toUTCString();
//   document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
// }
//
// // need consts to acceptCookies and rejectCookies
// const acceptCookies = () => {
//   setCookie('cookie_preference', {
//     essential_cookies: true,
//     additional_cookies: true
//   }, 30);
//   // setCookie('set_cookie_preference', true, 30);
// }
// // need const for cookie_preference cookie value, with default values
// // need event handlers for click acceptBtn & click rejectBtn
//
// acceptBtn.addEventListener("click", () => {
//   acceptCookies();
// });
//
//
// // need to add gtm classes to button in view, depending on cookie acceptance status
//
// // need datalayer push for accept & reject cookies
//
// // need to render confirmation banner or rejection banner once button clicked (and to hide original banner).
//
// // need event handler to close confirmation/rejection banner on 'hide this message' click
//
// // need to render banner or not, depending on whether cookie preference has already been set

export default initTestCookie;