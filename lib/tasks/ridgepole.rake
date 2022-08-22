# NOTE: command
#       bundle exec rake ridgepole:apply

namespace :ridgepole do
  desc "Apply ridgepole schemafile"
  task apply: :environment do
    ridgepole('--apply')
  end

  private

  def config_file
    "config/database.yml"
  end

  def ridgepole(*options)
    command = ['bundle exec ridgepole --file ./db/Schemafile', "-c #{config_file}", "-E #{Rails.env}"]
    system (command + options).join(' ')
  end
end
