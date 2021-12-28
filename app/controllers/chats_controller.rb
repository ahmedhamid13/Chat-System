# frozen_string_literal: true

class ChatsController < ApplicationController
  include Api::V1::Chat
  include Api::V1::SystemApplication
  before_action :set_application
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    # @chats = Chat.all
    @pagy, @chats = pagy(@application.chats)

    render json: { chats: chats_json(@chats, @includes), pagy: pagy_json(@pagy, @includes), application: application_json(@application) }
  end

  # GET /chats/1
  def show
    render json: { chat: chat_json(@chat, @includes), application: application_json(@application) }
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: { chat: chat_json(@chat, @includes), application: application_json(@application) }, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: { chat: chat_json(@chat, @includes), application: application_json(@application) }
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    def set_application
      @application = SystemApplication.find_by_token!(params[:application_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = @application.chats.find_by_number!(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      # params.require(:chat).permit(:application_id).merge(application: @application)
      { system_application: @application }
    end
end
