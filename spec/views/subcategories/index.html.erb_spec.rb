# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subcategories/index', type: :view do
  before(:each) do
    assign(:subcategories, [
      Subcategory.create!(
        name: 'Name',
        desc: 'MyText',
        category_id: 2
      ),
      Subcategory.create!(
        name: 'Name',
        desc: 'MyText',
        category_id: 2
      )
    ])
  end

  it 'renders a list of subcategories' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
