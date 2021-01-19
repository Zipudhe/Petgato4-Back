class ContactsController < ApplicationController
    before_action :set_contact, only: [:show, :destroy]
    MSGS_PER_PAGE = 5

    # GET /messages Mostra todas as mensagens de contato
    def index
        @page = params.fetch(:page, 0).to_i

        render_messages(@page)
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

        @page = params.fetch(:page, 0).to_i
        render_messages(@page)
    end

    def allcontacts
        contacts = Contact.all.reverse_order
        render json: contacts, status: 200
    end

    private

    def set_contact
        @contact = Contact.find(params[:id])
    end

    def contact_params
        params.require(:contact).permit(:name, :email, :description)
    end

    def render_messages page
        @messages = Contact.offset(@page*MSGS_PER_PAGE).limit(MSGS_PER_PAGE).reverse_order
        render json: @messages, status: 200
    end

end
