# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    pocket_username "robert"
    pocket_code "123456"
    provider "pocket"
    uid 'the_robert'
  end
end
