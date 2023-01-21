require_relative "../model_converter.rb"

namespace :typescript do
  desc "Generate TypeScript interfaces for ActiveRecord models. Interfaces include a property for each model attribute, with the property name and type corresponding to the attribute name and type."
  task migrate: :environment do
    Rails.application.eager_load!
    converter = ModelConverter.new
    converter.run!
  end
end
