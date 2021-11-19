require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do
    describe 'Validations' do
      it "Should save when all required fields are filled" do 
        @category = Category.new(name: 'Lamborghini Aventador')
        @product= Product.new({name:"Exotic Cars", category: @category, quantity:3, price: 250000 })
  
        @product.valid?
        expect(@product.errors.full_messages).to eq([])
      end 
  
      it "Should display name, cannot remain blank" do 
        @category = Category.new(name: 'Lamborghini Aventador')
        @product= Product.new({name:nil, category: @category, quantity: 3, price: 250000 })
  
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end 
  
      it "Should display quantity, cannot remain blank!" do 
        @category = Category.new(name: 'Lamborghini Aventador')
        @product= Product.new({name:"Exotic Cars", category: @category, quantity:nil, price: 250000 })
  
        @product.valid?
        expect(@product.errors.full_messages).to include("Quantity can't be blank")    
      end 
      
      it "Should display price, cannot remain blank" do 
        @category = Category.new(name: 'Lamborghini Aventador')
        @product= Product.new({name:"Exotic Cars", category: nil, quantity: 3, price: nil })
  
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end 

      it "Should display price, cannot remain blank" do 
        @category = Category.new(name: 'Lamborghini Aventador')
        @product= Product.new({name:"Exotic Cars", category: @category, quantity: 3, price: nil })
  
        @product.valid?
        expect(@product.errors.full_messages).to include("Price is not a number")
      end 
    end
  end
end
