# frozen_string_literal: true

class SubcategoriesController < ApplicationController
  before_action :set_subcategory, only: %i[ show edit update destroy ]
  def create
    @category = Category.find(params[:category_id])
    @subcategory = @category.subcategories.create(params[:subcategory].permit(:name, :desc))
    redirect_to @category
  end

  def destroy
    @category = Category.find(params[:category_id])
    @subcategory = @category.subcategories.find(params[:id])
    @subcategory.destroy
    redirect_to @category
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subcategory
      @category = Category.find(params[:category_id])
      @subcategory = @category.subcategories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subcategory_params
      params.require(:subcategory).permit(:name, :desc, :category_id)
    end
end
