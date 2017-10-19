class CustomersController < ApplicationController

  before_action :authenticate_user!

  def show
    @super_admin_emails = ['felipe@cpa.coop', 'jessica@cpa.coop', 'joe.naroditsky@cpa.coop', 'pauledwardmitchell@gmail.com']
    if @super_admin_emails.include? current_user.email
      qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
      qbo_api.class.production = true

      @customer = Customer.find(params[:id])
      @customer_object = qbo_api.get :customers, @customer.qbo_id
      #find all invoices for a certain vendor
      @all_invoices = qbo_api.all :invoices
      @customer_invoices = @all_invoices.reject { |i| i["CustomerRef"]["value"] != @customer.qbo_id.to_s}
      @customer_invoices_last_thirty_days = @customer_invoices.reject { |i| Time.parse(i['DueDate']).to_i < ((Date.today-30).to_time.to_i) || Time.parse(i['DueDate']).to_i > Date.today.to_time.to_i}
      @total_thirty = @customer_invoices_last_thirty_days.map { |i| i['TotalAmt'] }.reduce(:+)
      @balance_thirty = @customer_invoices_last_thirty_days.map { |i| i['Balance'] }.reduce(:+)

    else
      redirect_to current_user
    end


    #allc = c.reject {|c| c["DisplayName"][/^(Member -)/]}
  end

end
