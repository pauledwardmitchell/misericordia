class CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @customer_object = qbo_api.get :customers, @customer.qbo_id
    #find all invoices for a certain vendor
    @all_invoices = qbo_api.all :invoices
    @customer_invoices = @all_invoices.reject { |i| i["CustomerRef"]["value"] != @customer.qbo_id.to_s}


    #allc = c.reject {|c| c["DisplayName"][/^(Member -)/]}
  end

end
