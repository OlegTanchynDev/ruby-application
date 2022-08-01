# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subcategories/show', type: :view do
  before(:each) do
    @subcategory = assign(:subcategory, Subcategory.create!(
      name: 'Name',
      desc: 'MyText',
      category_id: 2
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
