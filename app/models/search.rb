class Search < ActiveRecord::Base
  extend Textacular

  attr_accessor :query

  belongs_to :searchable, polymorphic: true

  # self.table_name = 'searches'

  def results
    if @query.present?
      self.class.search(@query).preload(:searchable).map(&:searchable).uniq
    else
      Search.none
    end
  end
end