class Api::WelcomeController < ApplicationController
  def index
    render json: {info: 'About us'}
  end
end
