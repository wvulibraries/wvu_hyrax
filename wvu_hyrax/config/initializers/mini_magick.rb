# frozen_string_literal: true
require 'mini_magick'

MiniMagick.configure do |config|
  config.validate_on_create = false
  config.validate_on_write = false
  config.shell_api = "posix-spawn"
end
