module Pocket
  class Importer
    def initialize user
      @client = Pocket.client(:access_token => 'd68e4c86-7556-4f70-ac42-ad60dc' )
      # @client = Pocket.client(:access_token => user.pocket_code )
    end

    def ressources
      ressources = @client.retrieve(:detailType => :complete, :sort => :newest)
      result = []
      ressources["list"].each do |k,v|
        result << Pocket::Ressource.new(v)
      end
      result
    end
  end
end
