// TODO: we need to figure out if all the projects use the same container and if some projects don't use analytics at all
export function loadAnalytics() {
  if (!window.gaGlobal) {
    // Load gtm script
    // Script based on snippet at https://developers.google.com/tag-manager/quickstart
    // prettier-ignore
    (function (w, d, s, l, i) {
            w[l] = w[l] || []
            w[l].push({
                'gtm.start': new Date().getTime(),
                event: 'gtm.js'
            })

            const j = d.createElement(s)
            const dl = l !== 'dataLayer' ? `&l=${l}` : ''

            var csp_nonce = document.getElementsByName('csp-nonce')[0].getAttribute('content');
            j.async = true
            j.src = `https://www.googletagmanager.com/gtm.js?id=${i}${dl}`
            j.setAttribute('nonce',csp_nonce)
            document.head.appendChild(j)
        })(window, document, 'script', 'dataLayer', 'GTM-T5MB575')
  }
}

export function acceptCookiesGTMEvent() {
  window.dataLayer.push({
    event: "acceptAllCookies",
  });

  window.dataLayer.push({
    setCookiePreference: "True",
  });
}
