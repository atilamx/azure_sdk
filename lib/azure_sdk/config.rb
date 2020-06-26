module AzureSdk
  module Config
    extend self

    attr_accessor :tenant

    attr_accessor :appId

    attr_accessor :password

    def self.parse_configuration(file)
      @credentials = file.read
      extract_keys
    end

    def self.extract_keys
      keys = @credentials.split("\n")

      puts "Extracting keys.."

      set_values(keys)
    end

    private

    def self.set_values(keys)
      keys.each do |key|
        next if key.match?(/Azure-Account/)
        raise StandardError.new "The following key values are malformed :\'#{key}\'" unless key.match?(/[a-zA-Z].*(\s?|\s+)=(\s?|\s+)\S+/)

        key_temp = key.split("=").first.delete(' ')
        value = key.split("=").last.delete(' ')

        self.send("#{key_temp}=",value) #Fill the attributes automatically
      end
    end
  end
end