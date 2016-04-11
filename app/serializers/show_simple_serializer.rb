class ShowSimpleSerializer < ActiveModel::Serializer
  attributes :id, :show_number, :air_date, :show_url

  def show_url
    "#{api_show_url(object.id)}.json"
  end
end
