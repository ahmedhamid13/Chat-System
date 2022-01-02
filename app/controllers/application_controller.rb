# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Api::V1::Pagy
  before_action :set_includes

  def root
    render json: {
      postman_collection_url: "https://documenter.getpostman.com/view/12318086/UVRGDP8s",
      postman_json_url: "https://www.postman.com/collections/6ed2730407949c6a8158",
      site_performance: "https://chat-system-insta.herokuapp.com/admin/site_performance",
      sidekiq_web: "https://chat-system-insta.herokuapp.com/admin/sidekiq",
    }
  end

  # def homepage
  #   redirect_to homepage_url
  # end

  protected
    def set_includes
      @includes = params[:includes] ? JSON.parse(params[:includes]).map(&:to_sym) : []
    end
end
