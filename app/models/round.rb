class Round < ActiveRecord::Base
  has_many :questions
  belongs_to :show

  # @round.categories
  # Returns all categories appearing in a round
  def categories
    categories = Array.new
    self.questions.each do |question|
      categories << question.category
    end
    categories.uniq
  end
end
