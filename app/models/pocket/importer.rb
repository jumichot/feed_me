module Pocket
  class Importer

    def initialize user
      @client = Pocket.client(:access_token => user.pocket_code )
    end

    def ressources
      ressources = @client.retrieve(:detailType => :complete, :sort => :newest)
      ressources["list"].inject([]) do |result, hash|
        result << Pocket::Ressource.new(hash[1])
      end
    end

    def import_topics
      ressources.each do |ressource|
        tags = ressource.try(:tags)
        next if tags.nil?

        tags.each do |tag|
          Topic.where(name: tag[0]).first_or_create if tag[0].start_with?('#')
        end
      end
    end

    def import_ressources

    end

  end
end
