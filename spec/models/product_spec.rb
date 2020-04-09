require 'rails_helper'

RSpec.describe Product, type: :model do
#   subject {
#     described_class.new(name: "Something",
#                         price: 25,
#                         quantity: 1,
#                         category: "Games",
#                         user_id: 1)
# }

  describe 'Validations' do

    # it { is_expected.to validate_presence_of(:name)}

  it "is valid with valid attributes" do
    newCategory = Category.new
    newCategory.name = "Crafts"
    newProduct = Product.new
    newProduct.name = "Something"
    newProduct.price = 25
    newProduct.category = newCategory
    newProduct.quantity = 1
    expect(newProduct).to be_valid
  end

  it "is not valid without a name" do
    newCategory = Category.new
    newCategory.name = "Crafts"
    newProduct = Product.new
    newProduct.name = nil
    newProduct.price = 25
    newProduct.category = newCategory 
    newProduct.quantity = 1

    newProduct.save
    expect(newProduct.errors.full_messages).to include("Name can't be blank")

  end
  
  it "is not valid without a price" do
    newCategory = Category.new
    newCategory.name = "Crafts"
    newProduct = Product.new
    newProduct.name = "something"
    newProduct.price = nil
    newProduct.category = newCategory 
    newProduct.quantity = 1

    newProduct.save
    expect(newProduct.errors.full_messages).to include("Price is not a number")

  end
  it "is not valid without a quantity" do
    newCategory = Category.new
    newCategory.name = "Crafts"
    newProduct = Product.new
    newProduct.name = "something"
    newProduct.price = 25
    newProduct.category = newCategory 
    newProduct.quantity = nil

    newProduct.save
    expect(newProduct.errors.full_messages).to include("Quantity can't be blank")

  end
  it "is not valid without a category" do
    newProduct = Product.new
    newProduct.name = "something"
    newProduct.price = 25
    newProduct.category = nil
    newProduct.quantity = 1

    newProduct.save
    expect(newProduct.errors.full_messages).to include("Category can't be blank")
  end
  end
end
