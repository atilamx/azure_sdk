module AzureSdk
  module Config
    extend self

    attr_accessor :block_connection

    def self.basic_test
      5
    end

    def self.parse_configuration(file)
      credentials = file.read
      extract_keys(credentials.split("\n"))
    end

    def self.extract_keys(keys)
      needed_keys = ["tenant", "appId", "password"]
      puts "Extracting keys.."

      keys.each do |k|
        next if k.match?(/Azure-Accuount/)

        begin
          needed_keys.each do |needed_key|
            raise "The following key values is missing #{needed_key}" unless keys.match?(/"#{needed_key}"/)
          end
        rescue StandardError => e
          e.message
          exit
        end
      end
    end
  end
end