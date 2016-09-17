class Api::PostsController < ApplicationController
  before_action :set_post, only: [:destroy, :update]
  def index
    @posts = Post.all
    render json: @posts
   end

   def create
     @post = Post.new(post_params)
     if @post.save
       render json: @post
     else
       render json: {errors: @post.errors.full_messages}
     end
   end

   def destroy
     if @post.destroy
       render nothing: true
     end
   end

   def update
     if @post.update_attributes(post_params)
       render json: @post
     else
       render json: {errors: @post.errors.full_messages}
     end
   end

   private

   def set_post
     @post = Post.find(params[:id])
   end

   def post_params
     params.permit(:title, :body)
   end
end
