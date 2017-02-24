namespace :game do
  desc "ping NHL API and save new events"
  task :watch, [:game_id] => :environment do |t, args|
    GameWatcher.new(args[:game_id]).watch
  end
end
