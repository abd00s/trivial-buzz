class Category < ActiveRecord::Base
  has_many :questions

  # @category.appears_in
  # Returns instances of Show where @category appeared
  def appears_in
    shows = Array.new
    self.questions.each do |question|
      shows << question.round.show
    end
    shows.uniq
  end

  # Scope
  # Category.most_common(5)
  # Returns 5 most common categories
  # IMPORTANT: categories of questions revealed!
  def self.most_common(number=1)
    order('questions_count DESC').limit(number)
  end
end
