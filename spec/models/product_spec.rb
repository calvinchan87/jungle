require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it 'returns valid if all fields have valid values' do
      @category = Category.new name: 'Computer components'
      @product = Product.new name: 'EVGA FTW3 3080', price: 1199, quantity: 1, category: @category
      expect(@product).to be_valid
    end

    # validates: name, presence: true
    it 'does not return valid if product name == nil' do
      @category = Category.new name: 'Computer components'
      @product = Product.new name: nil, price: 1199, quantity: 1, category: @category
      expect(@product).to_not be_valid
    end

    # validates :price, presence: true
    it 'does not return valid if product price == nil' do
      @category = Category.new name: 'Computer components'
      @product = Product.new name: 'EVGA FTW3 3080', price: nil, quantity: 1, category: @category
      expect(@product).to_not be_valid
    end

    # validates :quantity, presence: true
    it 'does not return valid if product quantity == nil' do
      @category = Category.new name: 'Computer components'
      @product = Product.new name: 'PEVGA FTW3 3080', price: 1199, quantity: nil, category: @category
      expect(@product).to_not be_valid
    end

    # validates :category, presence: true
    it 'does not return valid if product category == nil' do
      @category = Category.new name: 'Computer components'
      @product = Product.new name: 'EVGA FTW3 3080', price: 1199, quantity: 1, category: nil
      expect(@product).to_not be_valid
    end

  end

end