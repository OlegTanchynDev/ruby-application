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
FactoryBot.define do
  factory :article do
    title { FFaker::Product.product_name }
    body { FFaker::Lorem.paragraph }
    category
    visit_count { rand(0..99) }
  end
end
