class Admin::CategoriesController < ApplicationController
  # authentication for categories
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]
  # We only want list, new & create. Use admin/products as an example.
  
  #list action
  def index
    @categories = Category.order(id: :desc).all
  end

  #new action
  def new
    @category = Category.new
  end

  #create action
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end


end