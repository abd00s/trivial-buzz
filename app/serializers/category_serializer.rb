class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :category_url

  def category_url
    "#{api_category_url(object.id)}.json"
  end
end
