class CommentsSerializer < ActiveModel::Serializer
  attributes :author, :body

  belongs_to :article
end
