# frozen_string_literal: true

class AppHeaderComponent < ViewComponent::Base
  def navigation_links
    [
      { url: "#", title: "Benefits" },
      { url: "#", title: "Work" },
      { url: "#", title: "Debt and money" },
      { url: "#", title: "Consumer" },
      { url: "#", title: "Housing" },
      { url: "#", title: "Family" },
      { url: "#", title: "Law and courts" },
      { url: "#", title: "Immigration" },
      { url: "#", title: "Health" }
    ]
  end
end
