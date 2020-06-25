module AzureSdk
  class Request
    module Actions
      def some_method
        puts "some_method"
        @saz = 5
      end
      def aqui
        @saz
      end
    end
  end
end
