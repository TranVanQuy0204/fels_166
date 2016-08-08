class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = Activity.includes(:user).paginate page: params[:page],
       per_page: Settings.per_page
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
