class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @blogs = general_blogs
    @featured_blogs = featured_blogs.last(6)
    @categories = Category.all.select(:id, :name)
  end

  private 
  def featured_blogs
    Blog.published.featured.select(:id, :title, :user_id, :published_at, :read_time, :category_id)
        .includes(:user, :category)
  end

  def general_blogs
    Blog.published.general.select(:id, :title, :user_id, :published_at, :read_time, :summary, :category_id)
        .includes(:user, :category)
  end
end
