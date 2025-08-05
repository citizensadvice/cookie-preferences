# frozen_string_literal: true

module CitizensAdviceCookiePreferences
  class FormOption
    attr_reader :id, :name

    def initialize(id:, name:)
      @id = id
      @name = name
    end
  end
end
