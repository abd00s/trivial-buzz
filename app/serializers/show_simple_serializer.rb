class ShowSimpleSerializer < ActiveModel::Serializer
  attributes :id, :show_number, :air_date, :url

  def url
    "#{api_show_url(object.id)}.json"
  end
end
