namespace :generate do
  desc "Generate TypeScript interfaces for ActiveRecord models. Interfaces include a property for each model attribute, with the property name and type corresponding to the attribute name and type."
  task :interfaces => :environment do
    Rails.application.eager_load!
    models = ApplicationRecord.descendants

    models.each do |model|
      # Get the model's attributes and their types
      attribute_types = model.columns.map { |col| [col.name, col.type, col.null] }

      # Generate the interface for the model
      interface_string = "export interface #{model.name} {\n"
      attribute_types.each do |name, type, nullable|
        nullable = nullable ? '?' : ''
        interface_string += "  #{name}#{nullable}: #{type.to_s.camelcase};\n"
      end
      interface_string += "}\n"

      # Write the interface to a file
      File.open("#{model.name.downcase}_interface.ts", 'w') do |file|
        file.puts(interface_string)
      end
    end
  end
end