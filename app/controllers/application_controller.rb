# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Api::V1::Pagy
  before_action :set_includes

  def homepage
    redirect_to homepage_url
  end

  protected
    def set_includes
      @includes = params[:includes] ? JSON.parse(params[:includes]).map(&:to_sym) : []
    end
end
