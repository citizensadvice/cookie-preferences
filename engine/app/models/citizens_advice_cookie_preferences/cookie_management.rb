# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class CookieManagement
    attr_reader :cookies
    attr_accessor :categorised_cookies

    def initialize(cookies)
      @cookies = cookies
      @categorised_cookies = {}
    end

    def delete_unconsented_cookies!
      categorise_cookies
      categorise_wildcard_cookies

      delete_unwanted_cookies!
    end

    private

    def categorise_cookies
      # rubocop:disable Style/HashEachMethods
      cookies.each do |name, _value|
        categorised_cookies[name] ||= COOKIE_CATEGORIES[name]
      end
      # rubocop:enable Style/HashEachMethods
    end

    def categorise_wildcard_cookies
      # rubocop:disable Style/HashEachMethods
      cookies.each do |name, _value|
        wildcard_name = wildcard_cookies.detect do |wildcard_cookie|
          prefix = wildcard_cookie[0..-2]
          name.start_with?(prefix)
        end

        categorised_cookies[name] ||= COOKIE_CATEGORIES[wildcard_name]
      end
      # rubocop:enable Style/HashEachMethods
    end

    def delete_unwanted_cookies!
      # Delete unconsented / uncategorised cookies
      categorised_cookies.each do |name, category|
        cookies.delete(name) if user_not_consented?(category)
        cookies.delete(name) if category.nil?
      end
    end

    def user_not_consented?(category)
      !cookie_preference[category]
    end

    def cookie_preference
      @cookie_preference ||= JSON.parse(cookies[:cookie_preference])
    end

    def wildcard_cookies
      @wildcard_cookies ||= COOKIE_CATEGORIES.select { |name| name.end_with?("*") }.keys
    end
  end
end
