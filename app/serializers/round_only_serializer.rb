class RoundOnlySerializer < ActiveModel::Serializer
  attributes :id, :name, :round_url

  has_one :show, serializer: ShowSimpleSerializer, root: :from_show

  def round_url
    "#{api_round_url(object.id)}.json"
  end
end
