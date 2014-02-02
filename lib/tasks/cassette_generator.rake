require "#{Rails.root}/lib/pocket/cassette_generator.rb"
namespace :pocket do
  desc "generate cassettes"
  task :cassettes => :environment do
    Pocket::CassetteGenerator.new
  end
end
