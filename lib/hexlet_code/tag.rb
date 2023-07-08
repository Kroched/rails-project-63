# frozen_string_literal: true

module HexletCode
  class Tag
    SINGLE_TAGS = %w[img br input].freeze
    PAIR_TAGS = %w[div label a].freeze

    class UnknownTagError < StandardError
    end

    def self.build(tag, **params)
      raise UnknownTagError if !single?(tag) && !pair?(tag)
      return "<#{tag}#{generate_params(params)}>" if single?(tag)
      return "<#{tag}#{generate_params(params)}>#{yield if block_given?}</#{tag}>" if pair?(tag)
    end

    private_class_method def self.single?(tag)
      SINGLE_TAGS.include? tag
    end

    private_class_method def self.pair?(tag)
      PAIR_TAGS.include? tag
    end

    private_class_method def self.generate_params(params)
      tmp = params.to_a
      tmp.empty? ? "" : " #{tmp.map { |param| "#{param[0]}=\"#{param[1]}\"" }.join}"
    end
  end
end
