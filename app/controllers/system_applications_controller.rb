# frozen_string_literal: true

class SystemApplicationsController < ApplicationController
  before_action :set_system_application, only: [:show, :update, :destroy]

  # GET /system_applications
  def index
    # @system_applications = SystemApplication.all
    @pagy, @system_applications = pagy(SystemApplication.all)

    render json: { system_applications: @system_applications, pagy: pagy_json(@pagy) }
  end

  # GET /system_applications/1
  def show
    render json: @system_application
  end

  # POST /system_applications
  def create
    @system_application = SystemApplication.new(system_application_params)

    if @system_application.save
      render json: @system_application, status: :created, location: @system_application
    else
      render json: @system_application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /system_applications/1
  def update
    if @system_application.update(system_application_params)
      render json: @system_application
    else
      render json: @system_application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /system_applications/1
  def destroy
    @system_application.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_application
      @system_application = SystemApplication.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def system_application_params
      params.require(:system_application).permit(:name, :token, :chats_count)
    end
end
