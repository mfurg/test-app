class Item < ApplicationRecord
    include PgSearch::Model

    pg_search_scope :search,
        against: %i[name description],
        using: {
                tsearch: {
                    prefix: true
                },
                trigram: {}
                }
end