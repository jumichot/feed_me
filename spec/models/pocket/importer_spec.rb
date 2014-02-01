require 'vcr'

describe Pocket::Importer do

  before(:all) do
    @client = Pocket::Importer.new(build :user)
  end

  describe "#ressources" do
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
        ressources = []
        ressources << create_ressource("#ruby")
        ressources << create_ressource("#ruby")
        ressources << create_ressource("useless")
        ressources << create_ressource("useless")
        ressources << create_ressource("#tool")
        @client.stubs(:ressources).returns(ressources)

        @client.import_topics
        expect(Topic.all.map{|t| t.name}).to eq ["#ruby","#tool"]
      end
    end

    it "create relationship with ressources" do
      VCR.use_cassette 'retrieve_complete' do
        ressources = []
        ressources << create_ressource("#ruby")
        ressources << create_ressource("#ruby")
        ressources << create_ressource("ruby")
        @client.stubs(:ressources).returns(ressources)

        @client.import_topics
        expect(Topic.first.ressources.count).to eq 2
      end
    end
  end


  describe "#import_ressources" do
    it "can import one ressource if resolved_id unique" do
      VCR.use_cassette 'retrieve_complete' do
        res1 = create(:pocket_ressource)
        res2 = create(:pocket_ressource, :resolved_id => 252)
        res3 = create(:pocket_ressource, :resolved_id => 252)
        ressources = [res1, res2, res3]

        @client.stubs(:ressources).returns(ressources)
        ressources.each do |ressource|
          @client.create_ressource ressource
        end

        expect(Ressource.count).to eq 2
        expect(Ressource.first.resolved_id).to eq res1.resolved_id.to_i
        expect(Ressource.last.resolved_id).to eq res2.resolved_id.to_i
      end
    end
  end

  def create_ressource tag
    create(:pocket_ressource,"tags" => {tag => {"item_id" => "522271957","tag" => "ruby"}})
  end
end