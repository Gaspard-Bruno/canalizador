module Canalizador
  class Utils
    def self.validate_environment_variables(*variables)
      missing_variables = variables.reject { |var| ENV[var] }

      return if missing_variables.empty?

      raise "Missing environment variables: #{missing_variables.join(', ')}"
    end
  end
end
