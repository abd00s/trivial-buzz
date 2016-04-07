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
end
