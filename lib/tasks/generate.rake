namespace :generate do
  desc "Generate TypeScript interfaces for ActiveRecord models. Interfaces include a property for each model attribute, with the property name and type corresponding to the attribute name and type."
  task :interfaces => :environment do
    Rails.application.eager_load!
    models = ApplicationRecord.descendants

    BASE_PATH = 'client/app/models/'

    rails_to_typescript = {
        integer: :number,
        text: :string,
        string: :string,
        datetime: :Date,
        decimal: :number,
    }

    models.each do |model|
      # Get the model's attributes and their types
      attribute_types = model.columns.map { |col| [col.name, col.type, col.null] }

      # Get the model's relationships
      relationships = model.reflect_on_all_associations

      # Generate the interface for the model
      interface_string = "export default interface #{model.name.demodulize} {\n"
      attribute_types.each do |name, type, nullable|
        nullable = nullable ? '?' : ''
        if rails_to_typescript[type].nil?
          raise "Model has a type '#{type}' which is missing a mapping to typescript. Edit rails_to_typescript in generate.rake"
        end
        interface_string += "  #{name}#{nullable}: #{rails_to_typescript[type]}\n"
      end

      relationships.each do |relationship|
        case relationship.macro
        when :has_one
          interface_string += "  #{relationship.name}?: #{relationship.class_name}\n"
        when :has_many
          interface_string += "  #{relationship.name}: #{relationship.class_name}[]\n"
        when :belongs_to
          interface_string += "  #{relationship.name}?: #{relationship.class_name}\n"
        end
      end

      interface_string += "}\n"

      # Write the interface to a file
      namespace = model.name.deconstantize
      namespace_path = namespace.empty? ? '' : "#{namespace.underscore}/"
      path = "#{BASE_PATH}#{namespace_path}#{model.name.demodulize}Model.ts"
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') do |file|
        file.puts(interface_string)
      end
    end
  end
end
