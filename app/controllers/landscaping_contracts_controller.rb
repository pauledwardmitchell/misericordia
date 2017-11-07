class LandscapingContractsController < ApplicationController

  def edit
    @contract = LandscapingContract.find(params[:id])
  end

  def update
  end

end
