# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subcategories/new', type: :view do
  before(:each) do
    assign(:subcategory, Subcategory.new(
      name: 'MyString',
      desc: 'MyText',
      category_id: 1
    ))
  end

  it 'renders new subcategory form' do
    render

    assert_select 'form[action=?][method=?]', subcategories_path, 'post' do
      assert_select 'input[name=?]', 'subcategory[name]'

      assert_select 'textarea[name=?]', 'subcategory[desc]'

      assert_select 'input[name=?]', 'subcategory[category_id]'
    end
  end
end
