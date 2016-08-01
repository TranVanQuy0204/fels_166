class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_word, only: [:update, :destroy, :edit]

  def new
    @word = Word.new
    @answers_show = 1
    @answers = Settings.max_answer.times {@word.word_answers.build}
  end

  def create
    @word = Word.create word_params
    if @word.save
      flash[:success] = t "messages.create_success"
      redirect_to admin_words_path
    else
      flash[:danger] = t "messages.create_failed"
      render :new
    end
  end

  def index
    @categories = Category.all
    if params[:search]
      @words = Word.filter_category(params[:search]).paginate page: params[:page],
        per_page: Settings.per_page
    else
      @words = Word.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.per_page
    end
  end

  def update
    if params[:category_id]
      load_category
      respond_to do |format|
        format.js {render json: {result: @word.update_category!(@category)}}
      end
    else
      if @word.word_updates! word_params
        flash[:success] = t ".success"
        redirect_to admin_words_path
      else
        flash[:danger] = t ".danger"
        render :edit
      end
    end
  end

  def destroy
    if params[:category_id]
      respond_to do |format|
        format.js {render json: {result:  @word.destroy_category!}}
      end
    else
      if @word.destroy_word!
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".danger"
      end
      redirect_to admin_words_path
    end

  end

  def edit
    @answers = @word.word_answers
    @answers_show = @answers.count
    (Settings.max_answer - @answers_show).times {@word.word_answers.build}
  end
  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

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
