# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieManagement
    attr_reader :cookies

    def initialize(cookies)
      @cookies = cookies
    end

    # rubocop:disable Style/HashEachMethods
    def delete_unconsented_cookies!
      cookies.each do |cookie, _|
        next if permitted_cookie?(cookie)
        next if malformed_cookie?(cookie)

        cookies.delete(cookie, domain: :all)
      end
    end
    # rubocop:enable Style/HashEachMethods

    private

    def permitted_cookie?(cookie)
      if cookie.in?(COOKIE_CATEGORIES.keys)
        COOKIE_CATEGORIES[cookie].in?(consented_categories)
      else
        wildcard_cookies.any? do |wildcard_cookie|
          wildcard_cookie_category = COOKIE_CATEGORIES[wildcard_cookie]
          start_string = wildcard_cookie.delete_suffix("*")
          cookie.start_with?(start_string) && wildcard_cookie_category.in?(consented_categories)
        end
      end
    end

    # this is the regexp defined in Rack::Utils, but that is a private so is replicated here
    VALID_COOKIE_KEY = /\A[!#$%&'*+\-.\^_`|~0-9a-zA-Z]+\z/
    private_constant :VALID_COOKIE_KEY

    def malformed_cookie?(cookie)
      !VALID_COOKIE_KEY.match?(cookie)
    end

    def wildcard_cookies
      @wildcard_cookies ||= COOKIE_CATEGORIES.select { |name| name.end_with?("*") }.keys
    end

    def consented_categories
      # Return an array of cookie categories where the value is true e.g. essential
      @consented_categories ||= JSON.parse(cookies[:cookie_preference]).select { |_categtory, value| value }.keys
    end
  end
end
