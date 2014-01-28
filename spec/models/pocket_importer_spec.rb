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
    it "can import one ressource" do
      VCR.use_cassette 'retrieve_complete' do
        ressources = []
        ressources << Pocket::Ressource.new({
         "item_id" => "107012738",
         "resolved_id" => "107012738",
         "given_url" => "http://wp.tutsplus.com/articles/how-to-change-your-wordpress-workflow-for-the-better/",
         "given_title" => "How To Change Your WordPress Workflow For The Better | Wptuts ",
         "favorite" => "0",
         "status" => "0",
         "time_added" => "1317547695",
         "time_updated" => "1317717340",
         "time_read" => "0",
         "time_favorited" => "0",
         "sort_id" => 534,
         "resolved_title" => "How To Change Your WordPress Publishing Workflow For The Better",
         "resolved_url" => "http://wp.tutsplus.com/articles/how-to-change-your-wordpress-workflow-for-the-better/",
         "excerpt" => "Running a blog has never been easier. Running a blog well is still a difficult task. Working with a team of people on a blog increases the challenge, so anything that makes that challenge a bit easier should be given a chance to show you its wares.",
         "is_article" => "1",
         "is_index" => "0",
         "has_video" => "0",
         "has_image" => "1",
         "word_count" => "2361",
         "tags" => {
          "wordpress" => {
            "item_id" => "107012738",
            "tag" => "wordpress"
          }
          },
          "authors" => {
            "3516903" => {
              "item_id" => "107012738",
              "author_id" => "3516903",
              "name" => "Ben Hutton",
              "url" => "http://wp.tutsplus.com/author/ben/"
            }
          }
        })

        @client.stubs(:ressources).returns(ressources)

        @client.import_ressources
        expect(Ressource.count).to eq 1
        expect(Ressource.first.resolved_id).to eq 107012738
      end
    end
  end

  def create_ressource tag
    Pocket::Ressource.new({"tags" => {tag => {"item_id" => "522271957","tag" => "ruby"}}})
  end
end
