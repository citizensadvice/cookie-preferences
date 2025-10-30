export function acceptCookiesGTMEvent() {
  if(window.dataLayer){
    window.dataLayer.push({
      event: "acceptAllCookies",
    });
    console.log('analytics-cookies-accepted');
  };
}