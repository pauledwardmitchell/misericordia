class LandscapingContractsController < ApplicationController

  def show
    @landscaping_contract = LandscapingContract.find(params[:id])
  end

  def edit
    @landscaping_contract = LandscapingContract.find(params[:id])

    #qbo customer hashes
    # @super_admin_emails = ['felipe@cpa.coop', 'jessica@cpa.coop', 'joe.naroditsky@cpa.coop', 'pauledwardmitchell@gmail.com']
    # if @super_admin_emails.include? current_user.email
    #   qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
    #   qbo_api.class.production = true

    #   @all_customers = qbo_api.all :customers
    #   @all_non_member_customers =  @all_customers.reject {|c| c["DisplayName"][/^(Member -)/]}
    # # end
    # @customer_hashes = []
    # @all_non_member_customers.each do |c|
    #   @customer_hash = {name: c["DisplayName"],
    #                     id: c["Id"]}
    #   @customer_hashes << @customer_hash
    # end
    @customer_hashes = [
      {name: "Name 1", id: 1},
      {name: "Name 2", id: 2}
    ]
  end

  def update
    @landscaping_contract = LandscapingContract.find(params[:id])

    if @landscaping_contract.update(landscaping_contract_params)
      redirect_to @landscaping_contract
    else
      render 'edit'
    end
  end

  private
  def landscaping_contract_params
    params.require(:landscaping_contract).permit(:name, :old_annual_payment, :cpa_annual_payment, :rebate_percentage, :contract_start_date, :contract_end_date, :cover_sheet_entered, :billing_start_date, :billing_end_date, :active, :qbo_customer_id)
  end

end
