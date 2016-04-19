class CreateIndecesOnQuestion < ActiveRecord::Migration
  def up
    execute "create index questions_body on questions using gin(to_tsvector('english', body))"
    execute "create index questions_response on questions using gin(to_tsvector('english', response))"
  end

  def down
      execute "drop index questions_body"
      execute "drop index questions_response"
    end
end
