# frozen_string_literal: true

module HexletCode
  module Tag
    def self.build(tag_name, **params, &)
      formatter = params[:formatter] || ClassicTagFormatter
      tag = AbstractTag.new(tag_name, **params, &)
      formatter.format(tag)
    end

    class AbstractTag
      TAGS = %w[div p textarea label input img br form].freeze

      attr_reader :name, :content, :params

      class UnknownTagError < StandardError; end

      def initialize(tag_name, **params, &block)
        raise UnknownTagError unless TAGS.include? tag_name

        @name = tag_name
        @content = block_given? ? block.call : ''
        @params = params
      end
    end

    module ClassicTagFormatter
      IDENT_SIZE = 2
      PAIR_TAGS = %w[div p label textarea form].freeze
      SINGLE_TAGS = %w[input img br].freeze

      def self.format(tag, ident_level = 0)
        generate_tag(tag, ident_level) do |children|
          result = []
          children.each do |t|
            result << format(t, ident_level + 1)
          end
          result.join "\n"
        end
      end

      private_class_method def self.generate_spaces(ident_level)
        ' ' * ident_level * IDENT_SIZE
      end

      private_class_method def self.generate_tag(tag, ident_level, &)
        return generate_single_tag(tag, ident_level) if SINGLE_TAGS.include? tag.name
        return generate_pair_text_tag(tag, ident_level) unless tag.content.instance_of?(Array)
        return generate_pair_text_tag(tag, ident_level, &) if tag.content.empty?

        generate_pair_nested_tag(tag, ident_level, &)
      end

      private_class_method def self.generate_single_tag(tag, ident_level)
        tag_name = tag.name
        params = generate_params tag.params
        "#{generate_spaces(ident_level)}<#{tag_name}#{params}>"
      end

      private_class_method def self.generate_pair_text_tag(tag, ident_level)
        tag_name = tag.name
        content = tag.content.empty? ? '' : tag.content
        params = generate_params tag.params
        "#{generate_spaces(ident_level)}<#{tag_name}#{params}>#{content}</#{tag_name}>"
      end

      private_class_method def self.generate_pair_nested_tag(tag, ident_level)
        tag_name = tag.name
        content = yield(tag.content) if block_given?
        params = generate_params tag.params
        "#{generate_spaces(ident_level)}<#{tag_name}#{params}>\n#{content}\n" \
          "#{generate_spaces(ident_level)}</#{tag_name}>"
      end

      private_class_method def self.generate_params(params)
        params = " #{params.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')}" unless params.empty?
        params = '' if params.empty?
        params
      end
    end
  end
end
