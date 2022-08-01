# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subcategories/edit', type: :view do
  before(:each) do
    @subcategory = assign(:subcategory, Subcategory.create!(
      name: 'MyString',
      desc: 'MyText',
      category_id: 1
    ))
  end

  it 'renders the edit subcategory form' do
    render

    assert_select 'form[action=?][method=?]', subcategory_path(@subcategory), 'post' do
      assert_select 'input[name=?]', 'subcategory[name]'

      assert_select 'textarea[name=?]', 'subcategory[desc]'

      assert_select 'input[name=?]', 'subcategory[category_id]'
    end
  end
end
