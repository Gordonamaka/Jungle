class Admin::DashboardController < ApplicationController
  #adds authentication for the dashboard info
  http_basic_authenticate_with name: ENV["HTTP_USERNAME"], password: ENV["HTTP_PASSWORD"]  
  
  def show
  
    @product_count = Product.count
    @category_count = Category.count
  
  end

end
