class Round < ActiveRecord::Base
  has_many :questions
  belongs_to :show
end
