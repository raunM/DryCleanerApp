class InvoicesController < ApplicationController
  before_action :find_invoice, only: [:show, :edit, :update, :destroy]

	def index
		@invoices = current_user.invoices.order("created_at DESC")
	end

	def show
	end

	def new
		@invoice = Invoice.new
	end

	def create
		@invoice = current_user.invoices.build(invoice_params)
		if @invoice.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @invoice.update(invoice_params)
			redirect_to invoice_path
		else
			render 'edit'
		end
	end

	def destroy
		@invoice.destroy
		redirect_to root_path
	end

	private
		def invoice_params
			params.require(:invoice).permit(:title, :description)
		end

		def find_invoice
			@invoice = current_user.invoices.find(params[:id])
		end
end