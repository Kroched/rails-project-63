# frozen_string_literal: true

module HexletCode
  def self.form_for(object, url: nil)
    method = "post"
    action = url || "#"
    form = Form.new(object, action: action, method: method)
    yield(form)
    form.build
  end

  class Form
    def initialize(object, action: "#", method: "post")
      @action = action
      @method = method
      @object = object
      @inner_form = []
    end

    def build
      inner_form.unshift("\n") unless inner_form.empty?
      build_wrapper { inner_form.join }
    end

    def input(field, as: :input, **kwargs)
      content = object.public_send(field)
      tag_name = TAG_MAP[as]
      kwargs[:name] = field
      kwargs[:type] = INPUT_TYPE_MAP[content.class.to_s.to_sym] if tag_name == "input"
      kwargs[:value] = content if tag_name == "input"
      tag = HexletCode::Tag.build(tag_name, **kwargs) { content }
      add_to_inner_form tag
    end

    def submit(value = nil)
      value ||= "save"
      tag = HexletCode::Tag.build("input", type: "submit", value: value)
      add_to_inner_form tag
    end

    private

    TAG_MAP = {
      text: "textarea",
      input: "input"
    }.freeze

    INPUT_TYPE_MAP = {
      String: "text"
    }.freeze

    attr_accessor :action, :method, :object, :inner_form

    def build_wrapper
      "<form action=\"#{action}\" method=\"#{method}\">#{yield if block_given?}</form>"
    end

    def add_to_inner_form(tag)
      inner_form << "  #{tag}\n"
    end
  end
end
