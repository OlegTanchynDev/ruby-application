# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  body        :text
#  title       :string
#  visit_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :string
#
class Article < ApplicationRecord
  validates :title, :presence => true,
            :length => { :minimum => 5 }

  has_many :comments, :dependent => :destroy
  belongs_to :category
  has_one_attached :cover_picture

  def self.ransckable_attributes(auth_object = nil)
    ["title", "published_at"]
  end
end
