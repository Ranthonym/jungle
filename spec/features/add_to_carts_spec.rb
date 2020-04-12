require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  product_article_elt = page.first(:xpath, "//form/button", text: 'Add')


  product_article_elt.click

  cart_elt = page.find(:xpath, "//a", text: 'My Cart')

  expect(page).to have_content("My Cart (1)")

  end
end
