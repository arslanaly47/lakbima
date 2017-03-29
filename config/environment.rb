# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Date::DATE_FORMATS.merge! default: "%d/%m/%Y"
