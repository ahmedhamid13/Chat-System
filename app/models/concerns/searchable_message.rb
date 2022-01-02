# frozen_string_literal: true

module SearchableMessage
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    # include Elasticsearch::Model::Callbacks

    index_name Rails.application.class.parent_name.underscore
    document_type self.name.downcase

    def as_indexed_json(_options = {})
      as_json(only: %i[slug body number created_at updated_at],
              include: {
                chat: {
                  only: [:number],
                },
              })
    end

    settings index: { number_of_shards: 1 } do
      mapping dynamic: false do
        indexes :slug, type: :text
        indexes :number, type: :integer
        indexes :body, type: :text, analyzer: :autocomplete
      end
    end

    def self.search(query)
      set_filters = lambda do |context_type, filter|
        @search_definition[:query][:bool][context_type] |= [filter]
      end

      @search_definition = {
        size: 5,
        query: {
          bool: {
            must: [],
            should: [],
            filter: [],
          },
        },
      }

      if query.blank?
        set_filters.call(:must, match_all: {})
      else
        set_filters.call(
          :must,
          match: {
            body: {
              query: query,
              fuzziness: 1,
            },
          },
        )
      end

      __elasticsearch__.search(@search_definition)
    end

    # class_methods do
    #   def settings_attributes
    #     {
    #       index: {
    #         analysis: {
    #           analyzer: {
    #             autocomplete: {
    #               type: :custom,
    #               tokenizer: :standard,
    #               filter: %i[lowercase autocomplete],
    #             },
    #           },
    #           filter: {
    #             autocomplete: {
    #               type: :edge_ngram,
    #               min_gram: 2,
    #               max_gram: 25,
    #             },
    #           },
    #         },
    #       },
    #     }
    #   end
    after_commit on: [:create] do
      __elasticsearch__.index_document
    end

    after_commit on: [:update] do
      __elasticsearch__.index_document
    end

    after_commit on: [:destroy] do
      __elasticsearch__.delete_document
    end
  end
end
