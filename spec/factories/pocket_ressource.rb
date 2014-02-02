# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  sequence :resolved_id do |n|
    n
  end
end

FactoryGirl.define do
  factory :pocket_ressource, :class => OpenStruct do
    skip_create
    item_id  "107012738"
    resolved_id
    given_url  "http://wp.tutsplus.com/articles/how-to-change-your-wordpress-workflow-for-the-better/"
    given_title  "How To Change Your WordPress Workflow For The Better | Wptuts "
    favorite  "0"
    status  "0"
    time_added  "1317547695"
    time_updated  "1317717340"
    time_read  "0"
    time_favorited  "0"
    sort_id  534
    resolved_title  "How To Change Your WordPress Publishing Workflow For The Better"
    resolved_url
    excerpt  "Running a blog has never been easier. Running a blog well is still a difficult task. Working with a team of people on a blog increases the challenge, so anything that makes that challenge a bit easier should be given a chance to show you its wares."
    is_article  "1"
    is_index  "0"
    has_video  "0"
    has_image  "1"
    word_count  "2361"
    initialize_with { new(attributes) }
  end
end
