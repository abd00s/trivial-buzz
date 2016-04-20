class CreateViewSearches < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE VIEW searches AS

        SELECT
          questions.id AS searchable_id,
          'Question' AS searchable_type,
          questions.body AS term
        FROM questions

        UNION

        SELECT
          questions.id AS searchable_id,
          'Question' AS searchable_type,
          questions.response AS term
        FROM questions

        UNION

        SELECT
          categories.id AS searchable_id,
          'Category' AS searchable_type,
          categories.name AS term
        FROM categories
        JOIN questions ON questions.category_id = categories.id
    SQL
  end

  def down
    execute "DROP VIEW searches"
  end
end
