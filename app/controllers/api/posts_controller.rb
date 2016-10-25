class Api::PostsController < ApplicationController
  before_action :set_post, only: [:destroy, :update]
  before_action only: [:update, :destroy, :create] do
    doorkeeper_authorize!
  end
  def index
    @posts  = Post.eager_load(:post_type).where(post_types: {name: params[:scope]}).order(created_at: :desc)
    render json: @posts
   end

   def create
     post_type = PostType.find_by(name: params[:scope])
     @post = Post.new(post_params.merge(post_type_id: post_type.id))
     if @post.save
       render json: @post
     else
       render json: {errors: @post.errors.full_messages}
     end
   end

   def destroy
     if @post.destroy
       head :ok
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
     params.permit(:title, :body, :banner)
   end
end
