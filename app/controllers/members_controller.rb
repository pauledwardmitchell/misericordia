class MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
    @pw_company = @member.pw_company

    @current_contract_data = []
    all_current_contracts = @member.all_current_contracts
    all_current_contracts.each do |contract|
      contract_data = {id: contract.id,
                       name: contract.name,
                       monthly_payment: contract.cpa_monthly_payment,
                       monthly_savings: contract.monthly_savings,
                       monthly_rebate: contract.monthly_rebate,
                       rebate_percentage: contract.rebate_percentage,
                       end_date: contract.contract_end_date,
                       contract_type: contract.class.to_s
                       }
      @current_contract_data << contract_data
    end

    @member_data = {name: @pw_company["name"],
                    institution_type: @member.institution_type(@pw_company["tags"]),
                    sell_list: @member.sell_list(all_current_contracts, @pw_company["tags"]),
                    pvr: @member.pvr(all_current_contracts, @pw_company["tags"]),
                    city_state: city_state_from_pw_company(@pw_company),
                    opportunities: @member.pw_unwon_opportunities
                   }
    @totals_data = {monthly_payment_total: all_current_contracts.map{|c| c.cpa_monthly_payment }.reduce(:+),
                    monthly_savings_total: all_current_contracts.map{|c| c.monthly_savings }.reduce(:+),
                    monthly_rebate_total: all_current_contracts.map{|c| c.monthly_rebate }.reduce(:+)
                   }

  end

  private

  def contract_classes(all_contracts)
    contract_types = all_contracts.map {|c| c.class.to_s}
    contract_types = contract_types.uniq
    contract_types
  end

  def city_state_from_pw_company(company)
    if company["address"]["city"] && company["address"]["state"]
      city_state = company["address"]["city"] + ", " + company["address"]["state"]
      city_state
    end
  end

end
