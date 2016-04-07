class Show < ActiveRecord::Base
  has_many :rounds
  has_many :questions, through: :rounds

  # @show.categories
  # Returns all categories appearing in a show
  def categories
    categories = Array.new
    self.questions.each do |question|
      categories << question.category
    end
    categories.uniq
  end
end
