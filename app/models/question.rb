class Question < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  belongs_to :round
end
