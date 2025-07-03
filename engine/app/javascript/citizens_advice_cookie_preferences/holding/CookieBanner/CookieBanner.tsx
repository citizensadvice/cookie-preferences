import { CookiesProvider, useCookies } from 'react-cookie';
import i18n from '../../locales/i18n';

function CookieBanner() {
    const [cookies, setCookie] = useCookies([
        'set_cookie_preference',
        'cookie_preference',
    ]);
    const [confirmationVisible, setConfirmationVisible] = React.useState(false);
    const [confirmationMessage, setConfirmationMessage] = React.useState('');
    const cookiePreference: boolean = cookies.set_cookie_preference;

    React.useEffect(() => {
        if (!cookiePreference) {
            setCookie('cookie_preference', {
                essential: true,
                settings: false,
                usage: false,
                campaigns: false,
            })
            setCookie('set_cookie_preference', 'false')
            window.dataLayer.push({
                event: 'cookieConsentDefault',
                setCookiePreference: false,
            });
        };
    }, []);

    type ConfirmationBannerProps = {
        message: string;
        onHide: () => void;
    };

    const ConfirmationBanner: React.FC<ConfirmationBannerProps> = ({
                                                                       message,
                                                                       onHide,
                                                                   }) => (
        <div
            className="cookie-banner"
            role="region"
            aria-label={i18n.cookieBanner.ariaLabel}
            data-testid="cookie-banner"
        >
            <div className="cads-grid-container">
                <h2 className="cookie-banner__text" aria-level={2}>
                    {message}{' '}
                </h2>
                <div>
                    <button type="button" className="cads-button" onClick={onHide}>
                        {i18n.cookieConfirmationBanner.buttonLabel}
                    </button>
                    <a href={i18n.cookieConfirmationBanner.linkHref}>
                        {i18n.cookieConfirmationBanner.linkText}
                    </a>
                    {i18n.cookieConfirmationBanner.linkCommentry}
                </div>
            </div>
        </div>
    );
    const acceptCookies = () => {
        setCookie('cookie_preference', {
            essential: true,
            settings: true,
            usage: true,
            campaigns: true,
        });
        setCookie('set_cookie_preference', 'true');
        window.dataLayer.push({
            event: 'cookieConsentUpdated',
            setCookiePreference: true,
        });
        setConfirmationMessage('You have accepted cookies');
        setConfirmationVisible(true);
    };

    const rejectCookies = () => {
        setCookie('cookie_preference', {
            essential: true,
            settings: false,
            usage: false,
            campaigns: false,
        });
        setCookie('set_cookie_preference', 'true');
        window.dataLayer.push({
            event: 'cookieConsentUpdated',
            setCookiePreference: true,
        });
        setConfirmationMessage('You have rejected cookies');
        setConfirmationVisible(true);
    };

    const handleHideConfirmation = () => {
        setConfirmationVisible(false);
    };

    return (
        <React.Fragment>
            {!cookiePreference && (
                <div
                    className="cookie-banner"
                    role="region"
                    aria-label={i18n.cookieBanner.ariaLabel}
                    data-testid="cookie-banner"
                >
                    <div className="cads-grid-container">
                        <h2 className="cookie-banner__text" aria-level={2}>
                            {i18n.cookieBanner.prose}{' '}
                        </h2>
                        <div>
                            <button
                                type="button"
                                className="cads-button gtm-accept-all-cookies"
                                onClick={acceptCookies}
                            >
                                {i18n.cookieBanner.buttonLabel}
                            </button>
                            <button
                                type="button"
                                className="cads-button"
                                onClick={rejectCookies}
                            >
                                {i18n.cookieBanner.rejectButtonLabel}
                            </button>
                            <a href={i18n.cookieBanner.linkHref}>
                                {i18n.cookieBanner.linkText}
                            </a>
                            {i18n.cookieBanner.linkCommentry}
                        </div>
                    </div>
                </div>
            )}
            {cookiePreference && confirmationVisible && (
                <ConfirmationBanner
                    message={confirmationMessage}
                    onHide={handleHideConfirmation}
                />
            )}
        </React.Fragment>
    );
}

function WrappedCookieBanner() {
    const expires = new Date();
    expires.setFullYear(expires.getFullYear() + 1);
    return (
        <CookiesProvider defaultSetOptions={{ path: '/', expires }}>
            <CookieBanner />
        </CookiesProvider>
    );
}

    export default WrappedCookieBanner;