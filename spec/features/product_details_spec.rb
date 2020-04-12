require 'rails_helper'

# feature spec that will test that users can navigate from the home page to the product detail page by clicking on a product

RSpec.feature "ProductDetails", type: :feature,  js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    p = Product.all.sample

    visit '/'

    expect(page).to have_text(p.name)

    product_article_elt = page.find(:xpath, "//a/h4", text: p.name)

    product_article_elt.click

    page.save_screenshot "clicked_before.png"

    expect(page).to have_selector 'section.products-show'
    expect(page).to have_text p.name

    page.save_screenshot "clicked_after.png"
  end


end
