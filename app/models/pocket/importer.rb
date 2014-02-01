module Pocket
  class Importer

    def initialize user
      @client = Pocket.client(:access_token => user.pocket_code )
    end

    def ressources
      ressources = @client.retrieve(:detailType => :complete, :sort => :newest)
      ressources["list"].inject([]) do |result, hash|
        result << OpenStruct.new(hash[1])
      end
    end

    def import_topics
      ressources.each do |ressource|
        tags = ressource.try(:tags)
        next if tags.nil?

        ressrc = create_ressource ressource
        tags.each do |tag|
          topic = Topic.where(name: tag[0]).first_or_create if tag[0].start_with?('#')
          topic.ressources << ressrc if topic
        end
      end
    end

    def create_ressource ressource
      ::Ressource.where(:resolved_id => ressource.resolved_id).first_or_create
    end

  end
end
