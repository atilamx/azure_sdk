require 'fileutils'
require 'azure_sdk/config'

module AzureSdk
  module SetupAccount
    def self.included(base)
      check_sdk_folder
      check_credentials_file
      load_configuration
    end

    def self.check_sdk_folder
      puts "Loading credentials"
      create_sdk_folder
    end

    def self.check_credentials_file
      conf_file = File.join(Dir.home,".azure_sdk","credentials.cnf")

      begin
        @file =File.open(conf_file)
      rescue StandardError => e
        puts e.message
        puts "Plese create the file first"
        exit
      end
    end

    def self.create_sdk_folder
      azure_sdk = File.join(Dir.home,".azure_sdk")
      Dir.mkdir(azure_sdk) unless Dir.exist?(azure_sdk)
    end

    def self.load_configuration
      AzureSdk::Config.parse_configuration(@file)
    end
  end
end
