class Question < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  belongs_to :round

  scope :random, -> { order("RANDOM()").first }

  # Only equality, range and subset checking are possible with Hash conditions
  # (not grater than and less than comparison).

  def self.newer_than(minimum)
    if minimum.present?
      newest = Show.order(air_date: :desc).first.air_date
      where({"shows.air_date" => minimum..newest})
    else
      all
    end
  end

  def self.older_than(maximum)
    if maximum.present?
      oldest = Show.order(:air_date).first.air_date
      where({"shows.air_date" => oldest..maximum})
    else
      all
    end
  end

  def self.value_greater(low_bound)
    if low_bound.present?
      where("value >= ?", low_bound)
    else
      all
    end
  end

  def self.value_less(upper_bound)
    if upper_bound.present?
      where("value <= ? AND value > ?", upper_bound, 0)
    else
      all
    end
  end

  def self.value_equals(value)
    if value.present?
      where(value: value.to_i)
    else
      all
    end
  end
end