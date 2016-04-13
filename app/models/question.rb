class Question < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  belongs_to :round

  scope :random, -> { order("RANDOM()").first }

  # Only equality, range and subset checking are possible with Hash conditions
  # (not grater than and less than comparison).

  def self.newer_than(minimum)
    if minimum.present?
      newest = Show.order(air_date: :desc).first.air_date
      includes(round: :show).where({"shows.air_date" => minimum..newest})
    else
      all
    end
  end

  def self.older_than(maximum)
    if maximum.present?
      oldest = Show.order(:air_date).first.air_date
      includes(round: :show).where({"shows.air_date" => oldest..maximum})
    else
      all
    end
  end
end