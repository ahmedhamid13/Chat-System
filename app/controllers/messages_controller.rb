# frozen_string_literal: true

class MessagesController < ApplicationController
  include Api::V1::Message
  include Api::V1::Chat
  include Api::V1::SystemApplication
  before_action :set_application
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    # @messages = Message.all
    if params[:q].present?
      @pagy, messages = pagy_array(@chat.messages.search(params[:q]))
      @messages = messages.map do |r|
        r.merge(r.delete('_source')).merge('id': r.delete('_id'))
      end
    else
      @pagy, @messages = pagy(@chat.messages)
    end


    render json: { messages: messages_json(@messages, @includes), pagy: pagy_json(@pagy, @includes), application: application_json(@application), chat: chat_json(@chat) }
  end

  # GET /messages/1
  def show
    render json: { message: message_json(@message, @includes), application: application_json(@application), chat: chat_json(@chat) }
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: { message: message_json(@message, @includes), application: application_json(@application), chat: chat_json(@chat) }, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: { message: message_json(@message, @includes), application: application_json(@application), chat: chat_json(@chat) }
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

  def set_application
    @application = SystemApplication.find_by_token!(params[:application_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = @application.chats.find_by_number!(params[:chat_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = @chat.messages.find_by_number!(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def message_params
    params.require(:message).permit(:body).merge(chat: @chat)
  end
end
