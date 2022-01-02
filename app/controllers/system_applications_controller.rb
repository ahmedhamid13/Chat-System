# frozen_string_literal: true

class SystemApplicationsController < ApplicationController
  include Api::V1::SystemApplication
  before_action :set_application, only: [:show, :update, :destroy]

  # GET /applications
  def index
    # @applications = SystemApplication.all
    @pagy, @applications = pagy(SystemApplication.all)

    render json: { applications: applications_json(@applications, @includes), pagy: pagy_json(@pagy, @includes) }
  end

  # GET /applications/1
  def show
    render json: application_json(@application, @includes)
  end

  # POST /applications
  def create
    @application = SystemApplication.new(application_params)

    if @application.save
      render json: application_json(@application, @includes), status: :created, location: application_url(@application.token)
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      render json: application_json(@application, @includes), location: application_url(@application.token)
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = SystemApplication.find_by_token!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name, :token)
    end
end
