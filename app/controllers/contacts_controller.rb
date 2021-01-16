class ContactsController < ApplicationController
    before_action :set_contact, only: [:show, :destroy]

    # GET /messages Mostra todas as mensagens de contato
    def index
        @contacts = Contact.all
        render json: @contacts, status: 200
    end

    # GET /messages/:id Mostra a mensagem que possui o id especificado na rota
    def show
        render json: @contact, status: 200
    end

    # POST /messages Cria uma nova mensagem
    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            render json: @contact, status: 201
        else
            render json: @contact.errors, status: 422
        end
    end

    # DELETE /messages/:id Deleta a mensagen de id especificado na rota
    def destroy
        @contact.destroy
    end

    private

    def set_contact
        @contact = Contact.find(params[:id])
    end

    def contact_params
        params.require(:contact).permit(:name, :email, :description)
    end

end
