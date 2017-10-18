class CustomersController < ApplicationController

  def show
    qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)

    @customer = Customer.find(params[:id])
    @customer_object = qbo_api.get :customers, @customer.qbo_id
    #find all invoices for a certain vendor
    @all_invoices = qbo_api.all :invoices
    @customer_invoices = @all_invoices.reject { |i| i["CustomerRef"]["value"] != @customer.qbo_id.to_s}


    #allc = c.reject {|c| c["DisplayName"][/^(Member -)/]}
  end

end
