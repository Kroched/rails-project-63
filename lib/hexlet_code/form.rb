# frozen_string_literal: true

module HexletCode
  def self.form_for(poro, **params)
    form = Form.new(poro, **params)
    yield(form) if block_given?
    form.build
  end

  class Form
    def initialize(poro, **params)
      @poro = poro
      @params = params.clone
      @fields = []
      normalize_params
    end

    def build
      HexletCode::Tag.build('form', **params) { fields }
    end

    def input(field, **params)
      value = poro.public_send(field)
      tag = params[:as] || :input
      params[:name] = field
      add_textarea(field, value, **params) if tag == :text
      add_input(field, value, **params) if tag == :input
    end

    def submit(value = 'Save')
      fields << HexletCode::Tag::AbstractTag.new('input', type: 'submit', value:)
    end

    private

    INPUT_TYPE_MAP = {
      String: 'text',
      TrueClass: 'checkbox',
      FalseClass: 'checkbox'
    }.freeze

    attr_accessor :params, :poro, :fields

    def add_input(field, value, **params)
      params[:type] ||= INPUT_TYPE_MAP[value.class.to_s.to_sym]
      params[:value] = params[:value] || value
      fields << build_label(field)
      fields << HexletCode::Tag::AbstractTag.new('input', **params)
    end

    def add_textarea(field, value, **params)
      params = params.clone
      params.delete(:as)
      fields << build_label(field)
      fields << HexletCode::Tag::AbstractTag.new('textarea', **params) { value }
    end

    def build_label(field)
      HexletCode::Tag::AbstractTag.new('label', for: field) { field.capitalize }
    end

    def normalize_params
      params[:action] = @params[:url] || '#'
      params[:method] ||= 'post'
      params.delete(:url)
    end
  end
end
