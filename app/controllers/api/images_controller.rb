class Api::ImagesController < ApplicationController
  before_action :set_post, except: :destroy
  before_action :set_image, only: [:destroy, :update]

  def create
    # byebug
    image = @post.images.new(image_params)
    if image.save
      response.headers['X-Frame-Options'] = 'ALLOWALL'
      # response.headers.delete('X-Frame-Options')
      reloaded_image = Image.find(image.id)
      reloaded_image.update(link: reloaded_image.url)
      render plain: reloaded_image.link
    else
      render json: {errors: image.errors.full_messages}
    end
  end

  def destroy
    if @image.destroy
      head :ok
    else
    end
  end

  def index
    @images = @post.images
    render json: @images
  end

  def update
    if @image.update(update_params)
      render json: @image
    else
      render json: {errors: @image.errors.full_messages}
    end
  end

  def show
    @image = Image.find(params[:id])
    render json: @image
  end

  def method_name

  end

  private

  def set_image
    @image = Image.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])

  end

  def image_params
    params.permit(:upload, :post_id)
  end

  def update_params
    params.require(:image).permit(:is_banner)

  end
end
