# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'categories/index', type: :view do
  before(:each) do
    assign(:categories, [
      Category.create!(
        name: 'Name',
        desc: 'MyText'
      ),
      Category.create!(
        name: 'Name',
        desc: 'MyText'
      )
    ])
  end

  it 'renders a list of categories' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
