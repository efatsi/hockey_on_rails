namespace :game do
  desc "ping NHL API and save new events"
  task watch: :environment do
    GameWatcher.new.watch
  end
end
