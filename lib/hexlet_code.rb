# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  autoload(:Tag, "/home/kroch4ka/rails-project-63/lib/hexlet_code/tag")
end

puts HexletCode::Tag.build("br", href: "path/to/image") { "dsds" }
