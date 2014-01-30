# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :resolved_url do |n|
    "site#{n}.com"
  end

  factory :ressource do
    resolved_id 1
    resolved_title
    resolved_url "MyString"
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
