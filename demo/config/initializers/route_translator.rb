# frozen_string_literal: true

RouteTranslator.config do |config|
  # Define a custom proc to get the locale from the URL segment.
  # By default the raw locale value is used but we use `cymraeg`
  # for welsh language content so we need to map that value.
  # https://github.com/enriclluelles/route_translator#configuration
  config.locale_segment_proc = lambda { |locale|
    case locale.to_sym
    when :cy
      "cymraeg"
    end
  }
end
