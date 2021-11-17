require 'rails_helper'

RSpec.feature "users can navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @sample_product_name = Faker::Hipster.sentence(3)

      @category.products.create!(
        name:  @sample_product_name,
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

  end

  scenario "Visit homepage and see all products" do
    visit root_path

    click_link(@sample_product_name)

    expect(page).to have_content("Apparel")

    save_screenshot
  end

end