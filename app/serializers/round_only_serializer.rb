class RoundOnlySerializer < ActiveModel::Serializer
  attributes :id, :name, :url

  has_one :show, serializer: ShowSimpleSerializer, root: :from_show

  def url
    "#{api_round_url(object.id)}.json"
  end
end
