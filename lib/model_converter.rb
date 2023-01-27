# ModelConverter
#
# Usage:
# converter = ModelConverter.new
# converter.run
class ModelConverter
    RAILS_TO_TYPESCRIPT = {
        integer: :number,
        text: :string,
        string: :string,
        datetime: :Date,
        decimal: :number,
        boolean: :boolean,
        jsonb: nil,                 # this is our way of saying "ignore this field type"     decimal: :number
    }.freeze
    BASE_PATH = "client/app/models/".freeze

    def initialize
        @models = ApplicationRecord.descendants
    end

    def run!
        @models.each do |model|
            generate_interface_for(model)
        end
    end

    private

    def generate_interface_for(model)
        cols = model.columns.map { |col| [col.name, col.type, col.null] }
        relationships = model.reflect_on_all_associations
        interface_string = "export default interface #{model.name.demodulize}Model {\n"

        cols.each do |name, type, nullable|
            nullable = nullable ? "?" : ""
            if RAILS_TO_TYPESCRIPT.keys.exclude?(type)
                raise "Model has a type '#{type}' which is missing a mapping to typescript. Edit rails_to_typescript in generate.rake"
            end

            if RAILS_TO_TYPESCRIPT[type].nil?
                commented = "//"
                comment = "  // #{type} column types are flagged to be ignored"
            end

            interface_string += "#{commented}    #{name}#{nullable}: #{RAILS_TO_TYPESCRIPT[type]}#{comment}\n"
        end

        attributes = model.attribute_names - model.column_names
        attributes.each do |name|
            type = model.attribute_types[name].type
            if RAILS_TO_TYPESCRIPT.keys.exclude?(type)
                raise "Model has a type '#{type}' which is missing a mapping to typescript. Edit rails_to_typescript in generate.rake"
            end

            if RAILS_TO_TYPESCRIPT[type].nil?
                commented = "//"
                comment = "  // #{type} column types are flagged to be ignored"
            end

            interface_string += "#{commented}    #{name}: #{RAILS_TO_TYPESCRIPT[type]}#{comment}\n"
        end

        relationships.each do |relationship|
            nullable = nullable_relationship?(model, relationship, cols)

            case relationship.macro
            when :has_one
                interface_string += "    #{relationship.name}#{nullable}: #{relationship.class_name.demodulize}Model\n"
            when :has_many                                                                                                                                         
                interface_string += "    #{relationship.name}#{nullable}: #{relationship.class_name.demodulize}Model[]\n"
            when :belongs_to                                                                                                                                     
                interface_string += "    #{relationship.name}#{nullable}: #{relationship.class_name.demodulize}Model\n"
            end
        end

        interface_string += "}\n"

        # Write the interface to a file
        namespace = model.name.deconstantize
        namespace_path = namespace.empty? ? "" : "#{namespace.underscore}/"

        imports = relationships.map do |relationship|
            rel_name = relationship.class_name.demodulize
            "import #{rel_name}Model from \"./#{rel_name}Model\"\n"
        end

        imports << "\n\n" if imports.size > 0
        interface_string.prepend(imports.join(""))

        path = "#{BASE_PATH}#{namespace_path}#{model.name.demodulize}Model.ts"
        FileUtils.mkdir_p(File.dirname(path))
        File.open(path, "w") do |file|
            file.puts(interface_string)
        end
    end

    def nullable_relationship?(from, to, cols)
        hash = {}
        cols.each do |name, type, nullable|
            hash[name.gsub("_id", "")] = nullable
        end
        nullable = hash[from.name.to_s.singularize] || hash[to.name.to_s.singularize]
        nullable ? "?" : ""
    end
end
