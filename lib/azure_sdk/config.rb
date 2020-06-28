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
      tmp_credentials = @credentials.split("\n")

      STDERR.puts "Extracting keys.."

      set_values(tmp_credentials)
    end

    private

    def self.set_values(tmp_credentials)
      tmp_credentials.each do |credential|
        next if credential.match?(/Azure-Account/)
        raise StandardError.new "The following credential is malformed :\'#{credential}\'" unless credential.match?(/[a-zA-Z].*(\s?|\s+)=(\s?|\s+)\S+/)

        key = credential.split("=").first.delete(' ')
        value = credential.split("=").last.delete(' ')

        self.send("#{key}=",value) #Fill the attributes automatically
      end
    end
  end
end