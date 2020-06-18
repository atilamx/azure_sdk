require 'azure_sdk/setup_account'
byebug
module AzureSdk 
  class VirtualMachines 
    include AzureSdk::SetupAccount 
 
    def test
      puts "ok"
    end 
  end
end
