require 'vcr'

describe Pocket::Importer do

  before(:all) do
    @client = Pocket::Importer.new(build :user)
  end

  def create_ressources(tags)
    tags.inject([]) do |ressources, tag|
      ressources << create_ressource(tag)
    end
  end

  def create_ressource tag
    create(:pocket_ressource,"tags" => {tag => {"item_id" => "522271957","tag" => "ruby"}})
  end

  describe "#ressources create array of ressources" do
    it "convert hash from pocket api to array of OpenStruct" do
      VCR.use_cassette 'retrieve_complete' do
        ressources =  @client.ressources
        expect(ressources.first.class).to eq OpenStruct
      end
    end
  end

  describe "#import_topics" do
    it "import only topics that start with # with no duplicates" do
      VCR.use_cassette 'retrieve_complete' do
        ressources = create_ressources ["#ruby","#ruby","useless","useless","#tool"]
        @client.stubs(:ressources).returns(ressources)

        @client.import_topics

        expect(Topic.all.map{|t| t.name}).to eq ["#ruby","#tool"]
      end
    end

    it "create relationship with ressources" do
      VCR.use_cassette 'retrieve_complete' do
        ressources = create_ressources ["#ruby","#ruby","ruby"]
        @client.stubs(:ressources).returns(ressources)

        @client.import_topics

        expect(Topic.first.ressources.count).to eq 2
        expect(Ressource.count).to eq 3
      end
    end
  end
end
