require 'vcr'

describe Pocket::Importer do

  before(:all) do
    @client = Pocket::Importer.new(build :user)
  end

  describe "#ressources" do
    it "retrieve all ressources" do
      VCR.use_cassette 'retrieve_complete' do
        ressources =  @client.ressources
        expect(ressources.first.class).to eq Pocket::Ressource
      end
    end
  end

  describe "#import_topics" do
    it "import only topics that start with # with no duplicates" do
      VCR.use_cassette 'retrieve_complete' do
        ressources = []
        ressources << create_ressource("#ruby")
        ressources << create_ressource("#ruby")
        ressources << create_ressource("ruby")
        ressources << create_ressource("useless")
        ressources << create_ressource("useless")
        ressources << create_ressource("tool")
        ressources << create_ressource("#tool")
        @client.stubs(:ressources).returns(ressources)

        @client.import_topics
        expect(Topic.count).to eq 2
        expect(Topic.all.map{|t| t.name}).to eq ["#ruby","#tool"]
      end
    end
  end


  describe "#import_ressources" do
    it "can import ressources by their resolved_id (unique)" do
      VCR.use_cassette 'retrieve_complete' do
        ressources = []
        ressources << create(:pocket_ressource)
        ressources << create(:pocket_ressource, :resolved_id => 252)
        ressources << create(:pocket_ressource, :resolved_id => 252)

        @client.stubs(:ressources).returns(ressources)

        @client.import_ressources
        expect(Ressource.count).to eq 2
        expect(Ressource.first.resolved_id).to eq 107012738
        expect(Ressource.last.resolved_id).to eq 252
      end
    end
  end

  def create_ressource tag
    Pocket::Ressource.new({"tags" => {tag => {"item_id" => "522271957","tag" => "ruby"}}})
  end
end
