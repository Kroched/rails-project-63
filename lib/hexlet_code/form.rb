# frozen_string_literal: true

module HexletCode
  def self.form_for(_poro, url: nil)
    method = "post"
    action = url || "#"
    "<form action=\"#{action}\" method=\"#{method}\"></form>"
  end
end
