class MonthlyContractsController < ApplicationController

  def show
    @monthly_contract = MonthlyContract.find(params[:id])

    @contract_data = {name: @monthly_contract.name,
                      id: @monthly_contract.id,
                      contract_start_date: @monthly_contract.contract_start_date,
                      contract_end_date: @monthly_contract.contract_end_date
                    }
  end

  def edit
    @monthly_contract = MonthlyContract.find(params[:id])
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
    @monthly_contract = MonthlyContract.find(params[:id])
    if @monthly_contract.update(monthly_contract_params)
      redirect_to @monthly_contract
    else
      render 'edit'
    end
  end

  private
  def monthly_contract_params
    params.require(:monthly_contract).permit(:name, :building_id, :old_monthly_payment, :cpa_monthly_payment, :rebate_percentage, :contract_start_date, :contract_end_date, :cover_sheet_entered, :active, :qbo_customer_id)
  end
end
