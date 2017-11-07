class LandscapingContractsController < ApplicationController

  def show
    @landscaping_contract = LandscapingContract.find(params[:id])
  end

  def edit
    @landscaping_contract = LandscapingContract.find(params[:id])

    #qbo customer hashes

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
    params.require(:landscaping_contract).permit(:name, :old_annual_payment, :cpa_annual_payment, :rebate_percentage, :contract_start_date, :contract_end_date, :cover_sheet_entered, :active)
  end

end
