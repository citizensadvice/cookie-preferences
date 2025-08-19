# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieManagement
    attr_reader :cookies

    def initialize(cookies)
      @cookies = cookies
    end

    def delete_unconsented_cookies!
      category_consent = JSON.parse(cookies[:cookie_preference])

      # rubocop:disable Style/HashEachMethods
      cookies.each do |cookie, _|
        # Find category where cookie name exactly matches
        category = COOKIE_CATEGORIES[cookie]

        # Find category where cookie name matches a wildcard
        if category.nil?
          matched_wildcard_cookie = wildcard_cookies.detect do |wildcard_cookie|
            start_string = wildcard_cookie.to_s[0..-2]

            cookie.start_with?(start_string)
          end

          if matched_wildcard_cookie.nil?
            cookies.delete(cookie)
            next
          end

          category = COOKIE_CATEGORIES[matched_wildcard_cookie]
        end

        # ignore 'essential' cookies
        next if category == "essential"

        # delete unconsented cookies
        cookies.delete(cookie) unless category_consent[category]
      end
      # rubocop:enable Style/HashEachMethods
    end

    private

    def wildcard_cookies
      @wildcard_cookies ||= COOKIE_CATEGORIES.select { |name| name.end_with?("*") }.keys
    end
  end
end