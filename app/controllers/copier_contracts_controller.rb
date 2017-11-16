class CopierContractsController < ApplicationController

  def show
    @copier_contract = CopierContract.find(params[:id])

    @contract_data = {name: @copier_contract.name,
                      id: @copier_contract.id,
                      contract_start_date: @copier_contract.scorecard_start_date,
                      contract_end_date: @copier_contract.scorecard_end_date
                    }
  end

  def edit
    @copier_contract = CopierContract.find(params[:id])
    # # @super_admin_emails = ['felipe@cpa.coop', 'jessica@cpa.coop', 'joe.naroditsky@cpa.coop', 'pauledwardmitchell@gmail.com']
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
    @copier_contract = CopierContract.find(params[:id])
    if @copier_contract.update(copier_contract_params)
      redirect_to @copier_contract
    else
      render 'edit'
    end
  end

  private
  def copier_contract_params
    params.require(:copier_contract).permit(:name, :estimated_savings, :scorecard_start_date, :scorecard_end_date, :invoice_date, :cover_sheet_entered, :active, :qbo_customer_id)
  end

end
