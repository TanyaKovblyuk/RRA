require 'uri'

class PostsController < ApplicationController
  def add_next
    @user = User.find_by(id: params[:user_id].to_i)
    @posts = @user.posts.last(10+params[:post].to_i).reverse
  end

  def create
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.posts.find_by(id: params[:id]).destroy
  end

  def index
  end

  def like
    (@post = Post.find_by(id: params[:id]))
    .ratings.create(user_id: params[:user_id],
                    estimator_id: current_user.id,
                    like: 1)
  end

  def dislike
    (@post = Post.find_by(id: params[:id]))
    .ratings.create(user_id: params[:user_id],
                    estimator_id: current_user.id,
                    dislike: 1)
  end

  private
    def post_params
      params.require(:post).permit(:text)
    end

    def image_params
      params.require(:post).permit(:image)
    end
end
