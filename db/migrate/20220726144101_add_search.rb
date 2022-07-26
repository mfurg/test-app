class AddSearch < ActiveRecord::Migration[7.0]
  def change
    execute "CREATE EXTENSION unaccent"
    execute "CREATE EXTENSION pg_trgm"
    execute "CREATE EXTENSION fuzzystrmatch"
  end
end
