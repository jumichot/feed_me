namespace :pocket do
  desc "import pocket ressources"
  task :import => :environment do
    Pocket::Importer.new(User.first).import! 
  end
end
