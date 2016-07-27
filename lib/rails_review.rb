require "rails_review/checker"
require "rails_review/error"
require "rails_review/version"
require "rails_review/railtie" if defined?(Rails)

module RailsReview
  class << self
    def start
      RailsReview::Checker.gemlock_check
      RailsReview::Checker.timezone_check
      RailsReview::Checker.custom_validator_directory_check
      RailsReview::Checker.app_directory_check
    end
  end
end
