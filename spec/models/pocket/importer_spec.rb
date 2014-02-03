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
        expect(@client.ressources.first.class).to eq OpenStruct
      end
    end
  end

  describe "#import!" do
    it "import only topics that start with # with no duplicates" do
      ressources = create_ressources ["#ruby","#ruby","useless","useless","#tool"]
      @client.stubs(:ressources).returns(ressources)
      @client.import!
      expect(Topic.all.map{|t| t.name}).to eq ["#ruby","#tool"]
    end

    it "create relationship with ressources" do
      ressources = create_ressources ["#ruby","#ruby","ruby"]
      @client.stubs(:ressources).returns(ressources)
      @client.import!
      expect(Topic.first.ressources.count).to eq 2
      expect(Ressource.count).to eq 3
    end

    it "update ressources if pocket ressources have changed" do
      create(:ressource, resolved_id: 58, resolved_title: "old title")
      ressources = [create(:pocket_ressource,"resolved_id" => "58", "resolved_title" => "new title" )]
      @client.stubs(:ressources).returns(ressources)
      @client.import!
      expect(Ressource.first.resolved_title).to eq "new title"
    end
  end

  describe "#create_ressource" do
    it "create all the fiels wanted" do
      ressource = create(:pocket_ressource,"resolved_title" => "toto en vacances","resolved_url" => "toto.com", "time_favorited" => "1317547695", "time_read" => "1317547695")
      created_ressource = @client.create_ressource(ressource)
      expect(created_ressource.resolved_url).to eq "toto.com"
      expect(created_ressource.resolved_title).to eq "toto en vacances"
      expect(created_ressource.time_added.to_s).to eq "2011-10-02 00:00:00 UTC"
      expect(created_ressource.time_updated.to_s).to eq "2011-10-04 00:00:00 UTC"
      expect(created_ressource.time_favorited.to_s).to eq "2011-10-02 00:00:00 UTC"
      expect(created_ressource.time_read.to_s).to eq "2011-10-02 00:00:00 UTC"
    end

    it "set nil for date not yet setted by pocket" do
      ressource = create(:pocket_ressource, "time_added" => "0", "time_updated" => "0", "time_favorited" => "0", "time_read" => "0")
      created_ressource = @client.create_ressource(ressource)
      expect(created_ressource.time_added).to be_nil
      expect(created_ressource.time_updated).to be_nil
      expect(created_ressource.time_favorited).to be_nil
      expect(created_ressource.time_read).to be_nil
    end
  end
end
