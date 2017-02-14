class ContactsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @created_contacts = @user.created_contacts
    @received_contacts = @user.received_contacts
    render json: @created_contacts + @received_contacts
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
      json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    begin
      @contact = Contact.find(params[:id])
      render json: @contact
    rescue ActiveRecord::RecordNotFound
      render text: "Contact not found."
    end
  end

  def update
    begin
      @contact = Contact.update(params[:id], contact_params)
      render json: @contact
    rescue ActiveRecord::RecordNotFound
      render text: "Contact not found."
    end
  end

  def destroy
    begin
      @contact = Contact.find(params[:id])
      @contact.destroy
      render json: @contact
    rescue ActiveRecord::RecordNotFound
      render text: "Contact not found."
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
