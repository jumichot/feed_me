require 'pocket'
require 'vcr'

module Pocket
  class CassetteGenerator
    def initialize
      VCR.configure do |c|
        c.cassette_library_dir = 'spec/cassettes'
        c.hook_into :webmock
      end

      Pocket.configure do |config|
        config.consumer_key = 'xxxx'
      end

      client = Pocket.client(:access_token => 'xxx' )

      VCR.use_cassette 'retrieve_complete' do
        client.retrieve(:detailType => :complete, :sort => :newest)
      end

      VCR.use_cassette 'retrieve_simple' do
        client.retrieve(:detailType => :simple, :sort => :newest)
      end

      VCR.use_cassette 'retrieve_favorites' do
        client.retrieve(:favorite => 1, :sort => :newest)
      end

      VCR.use_cassette 'retrieve_items_tagged_ruby' do
        client.retrieve(:tag => "ruby", :sort => :newest)
      end

      VCR.use_cassette 'retrieve_items_untagged' do
        client.retrieve(:tag => "_untagged_", :sort => :newest)
      end

      VCR.use_cassette 'retrieve_contentType' do
        client.retrieve(:contentType => :article, :sort => :newest)
      end

      VCR.use_cassette 'retrieve_contentType' do
        client.retrieve(:contentType => :video, :sort => :newest)
      end

      VCR.use_cassette 'retrieve_state_read' do
        client.retrieve(:state => :archive, :sort => :newest)
      end

      VCR.use_cassette 'retrieve_state_unread' do
        client.retrieve(:state => :unread, :sort => :newest)
      end
    end
  end
end
