class LandscapingContractsController < ApplicationController

  def show
    @landscaping_contract = LandscapingContract.find(params[:id])
  end

  def edit
    @landscaping_contract = LandscapingContract.find(params[:id])
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
    params.require(:landscaping_contract).permit(:name)
  end

end
