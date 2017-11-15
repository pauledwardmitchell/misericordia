class CleaningContractsController < ApplicationController

  def show
    @cleaning_contract = CleaningContract.find(params[:id])

    @contract_data = {name: @cleaning_contract.name,
                      id: @cleaning_contract.id,
                      contract_start_date: @cleaning_contract.contract_start_date,
                      contract_end_date: @cleaning_contract.contract_end_date
                    }
  end

  def edit
    @cleaning_contract = CleaningContract.find(params[:id])
    # # @super_admin_emails = ['felipe@cpa.coop', 'jessica@cpa.coop', 'joe.naroditsky@cpa.coop', 'pauledwardmitchell@gmail.com']
    # # if @super_admin_emails.include? current_user.email
    #   qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
    #   qbo_api.class.production = true

    #   @all_customers = qbo_api.all :customers
    #   @all_non_member_customers =  @all_customers.reject {|c| c["DisplayName"][/^(Member -)/]}
    # # end
    # @customer_arrays = []
    # @all_non_member_customers.each do |c|
    #   @customer_array = [ c["DisplayName"], c["Id"]]
    #   @customer_arrays << @customer_array
    # end
    # @customer_arrays
    @customer_arrays = [
      ["Name 1", 1],
      ["Name 2", 2]
    ]
  end

  def update
    @cleaning_contract = CleaningContract.find(params[:id])
    if @cleaning_contract.update(cleaning_contract_params)
      redirect_to @cleaning_contract
    else
      render 'edit'
    end
  end

  private
  def cleaning_contract_params
    params.require(:cleaning_contract).permit(:name, :building_id, :old_monthly_payment, :cpa_monthly_payment, :rebate_percentage, :contract_start_date, :contract_end_date, :cover_sheet_entered, :active, :qbo_customer_id)
  end

end
