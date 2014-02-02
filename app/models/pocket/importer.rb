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

    def import!
      ressources.each do |ressource|
        ressrc = create_ressource ressource

        tags = ressource.try(:tags)
        next if tags.nil?

        tags.each do |tag|
          ressrc.tag_list.add(tag[0])
          ressrc.save!
          Topic.where(name: tag[0]).first_or_create if tag[0].start_with?('#')
        end
      end
    end

    def create_ressource ressource
      res = ::Ressource.where(:resolved_id => ressource.resolved_id).first_or_create 
      res.resolved_url = ressource.resolved_url
      res.resolved_title = ressource.resolved_title
      res.time_added = format_pocket_date(ressource.time_added)
      res.time_updated = format_pocket_date(ressource.time_updated)
      res.time_favorited = format_pocket_date(ressource.time_favorited)
      res.time_read = format_pocket_date(ressource.time_read)
      res.save
      res
    end

    def format_pocket_date(date)
      Date.strptime(date, '%s') unless date == "0"
    end

  end
end
