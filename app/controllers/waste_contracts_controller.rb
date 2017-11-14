class WasteContractsController < ApplicationController

  def show
    @waste_contract = WasteContract.find(params[:id])

    @contract_data = {name: @waste_contract.name,
                      id: @waste_contract.id,
                      contract_start_date: @waste_contract.contract_start_date,
                      contract_end_date: @waste_contract.contract_end_date
                    }
  end

  def edit
    @waste_contract = WasteContract.find(params[:id])
    # @super_admin_emails = ['felipe@cpa.coop', 'jessica@cpa.coop', 'joe.naroditsky@cpa.coop', 'pauledwardmitchell@gmail.com']
    # if @super_admin_emails.include? current_user.email
      qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
      qbo_api.class.production = true

      @all_customers = qbo_api.all :customers
      @all_non_member_customers =  @all_customers.reject {|c| c["DisplayName"][/^(Member -)/]}
    # end
    @customer_arrays = []
    @all_non_member_customers.each do |c|
      @customer_array = [ c["DisplayName"], c["Id"]]
      @customer_arrays << @customer_array
    end
    @customer_arrays
    # @customer_arrays = [
    #   ["Name 1", 1],
    #   ["Name 2", 2]
    # ]
  end

  def update
    @waste_contract = WasteContract.find(params[:id])
    if @waste_contract.update(waste_contract_params)
      redirect_to @waste_contract
    else
      render 'edit'
    end
  end

  private
  def waste_contract_params
    params.require(:waste_contract).permit(:name, :building_id, :old_monthly_payment, :cpa_monthly_payment, :rebate_percentage, :contract_start_date, :contract_end_date, :cover_sheet_entered, :active, :qbo_customer_id)
  end

end
