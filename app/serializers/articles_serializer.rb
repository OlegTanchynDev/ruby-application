class ArticlesSerializer < ActiveModel::Serializer
  attributes :title, :body

  has_many :comments, :dependent => :destroy
  belongs_to :category
  has_one_attached :cover_picture
end
