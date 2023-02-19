class RouteConverter
	BASE_PATH = "client/app/".freeze

	def initialize
		@routes = Rails.application.routes.routes
		@routes_hash = {}
	end

	def run!
		@routes.each do |route|
			if (route.verb.to_s =~ /^(GET|POST|DELETE)$|^$/) && (route.path.spec.to_s !~ /(?!\/rails\/)/)
				name = route.name
				path = route.path.spec.to_s.gsub(/\(\.:format\)/, "")
				url = "https://your-rails-app.com#{path}"

				# Check if the URL has already been added
				if @routes_hash.values.none? { |v| v[:url] == url }
					@routes_hash[name] = {path: path, url: url}
				end
			end
		end

		output = "export interface RailsRoutes {\n"

		@routes_hash.each do |name, route|
			output += "		#{name}: '#{route[:path]}',\n"
			output += "		#{name}_url: '#{route[:url]}',\n"
		end

		output += "}"

		File.write("#{BASE_PATH}rails_routes.ts", output)
	end
end
