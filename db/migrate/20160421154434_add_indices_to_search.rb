class AddIndicesToSearch < ActiveRecord::Migration
  def up
    execute "create index searches_term on searches using gin(to_tsvector('english', term))"
    execute "create index searches_type on searches using gin(to_tsvector('english', searchable_type))"
  end

  def down
      execute "drop index searches_term"
      execute "drop index searches_type"
    end
end
