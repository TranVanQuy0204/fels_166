class Admin::CategoryWordsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_category, only: :update
  before_action :load_word, only: [:update, :destroy]

  def update
    result =false
    if @word.update_category! @category
      result = true
    end
    respond_to do |format|
      format.js {render json: {result: result}}
    end
  end
  def destroy
    result =false
    if @word.destroy_category!
      result = true
    end
    respond_to do |format|
      format.js {render json: {result: result}}
    end
  end

  private

  def load_word
    @word = Word.find_by id: params[:id]
    if @word.nil?
      flash[:danger] = t "admin.category.find"
      redirect_to request.referrer
    end
  end

  def load_category
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      flash[:danger] = t "admin.category.find"
      redirect_to request.referrer
    end
  end
end
