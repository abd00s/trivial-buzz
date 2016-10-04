class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :url

  def url
    "#{api_category_url(object.id)}.json"
  end
end
