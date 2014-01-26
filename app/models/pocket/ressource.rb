module Pocket
  class Ressource
    attr_reader :options
    def initialize options
      @options = options
      options.each_pair do |k,v|
        instance_variable_set("@#{k}",v)
        eigenclass = class<<self; self; end
        eigenclass.class_eval do
          attr_accessor k
        end
      end
    end
  end
end



