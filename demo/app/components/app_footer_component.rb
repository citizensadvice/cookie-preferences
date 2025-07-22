# frozen_string_literal: true

class AppFooterComponent < ViewComponent::Base
  def call
    render CitizensAdviceComponents::Footer.new do |c|
      c.with_feedback_link(url: "https://example.com/")
    end
  end
end
