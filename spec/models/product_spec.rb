require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new(:name => "test_category")
  end

  describe 'Validations' do
    it "should create a new product if all required fields are met" do
      product = Product.new(:name => "jon", :price => 15, :quantity => 15, :category => @category)
      product.valid?
    end

    it "should not create a new product if the product name is missing" do
      product = Product.new(:name => nil, :price => 15, :quantity => 15, :category => @category)
      product.valid?
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not create a new product if the product price is missing" do
      product = Product.new(:name => "jon", :price => nil, :quantity => 15, :category => @category)
      product.valid?
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not create a new product if the product quantity is missing" do
      product = Product.new(:name => "jon", :price => 15, :quantity => nil, :category => @category)
      product.valid?
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not create a new product if the product category is missing" do
      product = Product.new(:name => "jon", :price => 15, :quantity => 15, :category => nil)
      product.valid?
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
