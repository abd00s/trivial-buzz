class RoundSerializer < ActiveModel::Serializer
  attributes :id, :name, :round_url

  has_many :questions

  def round_url
    "#{api_round_url(object.id)}.json"
  end
end
