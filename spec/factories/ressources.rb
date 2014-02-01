# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :resolved_url do |n|
    "site#{n}.com"
  end
end

FactoryGirl.define do
  factory :ressource do
    resolved_id
    resolved_title "the title"
    resolved_url
    excerpt "MyText"
    word_count 1
    favorite ""
    status 1
    time_added "2014-01-28 14:13:34"
    time_updated "2014-01-28 14:13:34"
    time_read "2014-01-28 14:13:34"
    time_favorited "2014-01-28 14:13:34"
  end
end
