class ElectricityContractsController < ApplicationController

  def index
    @current_electricity_contracts = ElectricityContract.all.select{ |c| c.current? }
    @contracts_array =[]
    @current_electricity_contracts.each do |contract|
      @contract_data = {name: contract.name,
                        id: contract.id,
                        contract_start_date: contract.contract_start_date,
                        contract_end_date: contract.contract_end_date,
                        rebate_to_cpa: contract.rebate_to_cpa,
                        cpa_negotiated_price: contract.cpa_negotiated_price,
                        total_kwh_expected: contract.total_kwh_expected,
                        annual_rebate: contract.annualized_revenue(2017)
                        }
      @contracts_array << @contract_data
      @contracts_array
    end
    @contracts_array
  end

  def show
    @electricity_contract = ElectricityContract.find(params[:id])

    @contract_data = {name: @electricity_contract.name,
                      id: @electricity_contract.id,
                      contract_start_date: @electricity_contract.contract_start_date,
                      contract_end_date: @electricity_contract.contract_end_date
                    }
  end

  def edit
    @electricity_contract = ElectricityContract.find(params[:id])
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
    @electricity_contract = ElectricityContract.find(params[:id])
    if @electricity_contract.update(electricity_contract_params)
      redirect_to @electricity_contract
    else
      render 'edit'
    end
  end

  private
  def electricity_contract_params
    params.require(:electricity_contract).permit(:name, :pw_organization_id, :annual_kwh, :price_to_compare, :cpa_negotiated_price, :contract_start_date, :contract_end_date, :qbo_customer_id, :rebate_to_cpa, :rebate_to_broker, :estimated_savings, :ldc_id, :total_kwh_expected, :supplier, :cover_sheet_entered, :invoices_generated, :active)
  end

end
