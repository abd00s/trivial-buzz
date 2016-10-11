class Category < ActiveRecord::Base
  has_many :questions

  # @category.shows
  # Returns instances of Show where @category appeared
  def shows
    self.questions.collect {|question| question.round.show}.uniq
  end

  # Scope
  # Category.most_common(5)
  # Returns 5 most common categories
  # IMPORTANT: categories of questions revealed!
  def self.most_common(number)
    if number.present?
      order('questions_count DESC').limit(number)
    else
      all
    end
  end

  def self.minimum_question_count(minimum)
    if minimum.present?
      where("questions_count >= ?", minimum).order(:questions_count)
    else
      all
    end
  end
end
