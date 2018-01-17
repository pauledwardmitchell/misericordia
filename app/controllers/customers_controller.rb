class CustomersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @super_admin_emails = ['felipe@cpa.coop', 'jessica@cpa.coop', 'joe.naroditsky@cpa.coop', 'pauledwardmitchell@gmail.com']
    if @super_admin_emails.include? current_user.email
      qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
      qbo_api.class.production = true

      @all_invoices = qbo_api.all :invoices
      @last_quarter_invoices = @all_invoices.reject { |i| Time.parse(i['DueDate']).to_i < Time.parse(begin_day_of_last_quarter).to_i || Time.parse(i['DueDate']).to_i > Time.parse(end_day_of_last_quarter).to_i}
      @last_quarter_total = @last_quarter_invoices.map { |i| i['TotalAmt'] }.reduce(:+)
      @last_quarter_balance = @last_quarter_invoices.map { |i| i['Balance'] }.reduce(:+)
      @last_quarter_collected = @last_quarter_total - @last_quarter_balance

    end
  end

  def index
    @customer = {qbo_id: "27", display_name: "Test Vendor"}

    @data = {
      total_thirty: 1234,
      balance_thirty: 2134,
      total_last_quarter: 432,
      balance_last_quarter: 1234,
      total_year_to_date: 43213,
      balance_year_to_date: 43212
    }
  end

  def show
    @super_admin_emails = ['felipe@cpa.coop', 'jessica@cpa.coop', 'joe.naroditsky@cpa.coop', 'pauledwardmitchell@gmail.com']
    if @super_admin_emails.include? current_user.email
      qbo_api = QboApi.new(access_token: Qbo.first.access_token, realm_id: Qbo.first.realm_id)
      qbo_api.class.production = true

      @customer = Customer.find(params[:id])
      @customer_object = qbo_api.get :customers, @customer.qbo_id
      #find all invoices for a certain vendor
      @all_invoices = qbo_api.all :invoices
      @customer_invoices = @all_invoices.reject { |i| i["CustomerRef"]["value"] != @customer.qbo_id.to_s}

      #Last 30 days
      @customer_invoices_last_thirty_days = @customer_invoices.reject { |i| Time.parse(i['DueDate']).to_i < ((Date.today-30).to_time.to_i) || Time.parse(i['DueDate']).to_i > Date.today.to_time.to_i}
      @total_thirty = @customer_invoices_last_thirty_days.map { |i| i['TotalAmt'] }.reduce(:+)
      @balance_thirty = @customer_invoices_last_thirty_days.map { |i| i['Balance'] }.reduce(:+)

      #Last quarter
      @customer_invoices_last_quarter = @customer_invoices.reject { |i| Time.parse(i['DueDate']).to_i < Time.parse(begin_day_of_last_quarter).to_i || Time.parse(i['DueDate']).to_i > Time.parse(end_day_of_last_quarter).to_i}
      @total_last_quarter = @customer_invoices_last_quarter.map { |i| i['TotalAmt'] }.reduce(:+)
      @balance_last_quarter = @customer_invoices_last_quarter.map { |i| i['Balance'] }.reduce(:+)

      #Year to date
      @customer_invoices_year_to_date = @customer_invoices.reject { |i| Time.parse(i['DueDate']).to_i < Time.parse(Date.today.year.to_s + "-01-01").to_i || Time.parse(i['DueDate']).to_i > Date.today.to_time.to_i}
      @total_year_to_date = @customer_invoices_year_to_date.map { |i| i['TotalAmt'] }.reduce(:+)
      @balance_year_to_date = @customer_invoices_year_to_date.map { |i| i['Balance'] }.reduce(:+)

      @data = {
        total_thirty: @total_thirty,
        balance_thirty: @balance_thirty,
        total_last_quarter: @total_last_quarter,
        balance_last_quarter: @balance_last_quarter,
        total_year_to_date: @total_year_to_date,
        balance_year_to_date: @balance_year_to_date
      }

      @contracts = all_contracts.select { |c| c.qbo_customer_id == @customer.qbo_id }

    else
      redirect_to current_user
    end


    #allc = c.reject {|c| c["DisplayName"][/^(Member -)/]}
  end

  private

  def end_day_of_last_quarter
    case Date.today.month
    when 1, 2, 3
      return (Date.today.year - 1).to_s + "-12-31"
    when 4, 5, 6
      return Date.today.year.to_s + "-03-31"
    when 7, 8, 9
      return Date.today.year.to_s + "-06-30"
    when 10, 11, 12
      return Date.today.year.to_s + "-09-30"
    end
  end

  def begin_day_of_last_quarter
    case Date.today.month
    when 1, 2, 3
      return (Date.today.year - 1).to_s + "-10-01"
    when 4, 5, 6
      return Date.today.year.to_s + "-01-01"
    when 7, 8, 9
      return Date.today.year.to_s + "-04-01"
    when 10, 11, 12
      return Date.today.year.to_s + "-07-01"
    end
  end

  def all_contracts
    landscaping_contracts = LandscapingContract.all
    waste_contracts = WasteContract.all
    cleaning_contracts = CleaningContract.all
    security_contracts = SecurityContract.all
    electricity_contracts = ElectricityContract.all
    gas_contracts = GasContract.all
    copier_contracts = CopierContract.all
    solar_contracts = SolarContract.all
    monthly_contracts = MonthlyContract.all
    contracts_array = landscaping_contracts + waste_contracts + cleaning_contracts + security_contracts + electricity_contracts + gas_contracts + copier_contracts + solar_contracts + monthly_contracts
    contracts_array
  end

end
