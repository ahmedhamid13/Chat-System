class ApplicationController < ActionController::API
  include Pagy::Backend
  include Api::V1::Pagy
  before_action :set_includes

  protected

  def set_includes
    @includes = params[:includes] ? JSON.parse(params[:includes]).map(&:to_sym) : []
  end
end
