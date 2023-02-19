require_relative "../model_converter"
require_relative "../route_converter"

namespace :typescript do
  desc "Generate TypeScript interfaces for ActiveRecord models. Interfaces include a property for each model attribute, with the property name and type corresponding to the attribute name and type."
  task migrate: :environment do
    Rails.application.eager_load!
    converter = ModelConverter.new
    converter.run!
  end

  desc "Extract Rails routes and generate TypeScript file"
  task routes: :environment do
    Rails.application.eager_load!
    converter = RouteConverter.new
    converter.run!
  end
end
