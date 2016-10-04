class RoundSimpleSerializer < ActiveModel::Serializer
  attributes :id, :name, :url

  has_many :questions

  def url
    "#{api_round_url(object.id)}.json"
  end
end
