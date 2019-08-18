#!/bin/ruby

require_relative 'backup'

REQUIRED_ENVIRONMENT_VARIABLES = %w[
  FTP_HOST
  FTP_USERNAME
  FTP_PASSWORD
  WORLD_DIR
].freeze

REQUIRED_ENVIRONMENT_VARIABLES.each do |required_env_var|
  unless ENV[required_env_var]
    puts "Expecting environment variable #{required_env_var} to be set to non-empty string. Exiting."
    exit 3
  end
end

Minecraft::Backup.create(ENV['WORLD_DIR'])

exit true
