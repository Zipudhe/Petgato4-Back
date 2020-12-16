class ContactsController < ApplicationController
    before_action :set_contact, only: [:show, :destroy]

    private

    def set_contact
        @contact = Contact.find(params[:id])
    end

    def contact_params
        params.require(:contact).permit(:name, :email, :description)
    end

end
