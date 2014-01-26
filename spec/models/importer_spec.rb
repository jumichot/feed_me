require 'vcr'

describe Pocket::Importer do

  before(:all) do
    @client = Pocket::Importer.new(build :user)
  end


  it "retrieve all ressources" do
    VCR.use_cassette 'retrieve_complete' do
      ressources =  @client.ressources
      expect(ressources.first.class).to eq Pocket::Ressource
    end
  end
end
