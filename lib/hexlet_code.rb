# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative "hexlet_code/form"

module HexletCode
  autoload(:Tag, File.join(PROJECT_PATH, "lib", "hexlet_code", "tag.rb"))
end
