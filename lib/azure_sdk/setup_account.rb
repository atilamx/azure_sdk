module AzureSdk
  module SetupAccount
    def self.included(base)
      puts "#{base} included #{self}"
    end
 
    def load_credentials
      puts "loading credentials"   
    end 
  end
end
