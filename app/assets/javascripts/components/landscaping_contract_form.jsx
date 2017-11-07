const LandscapingContractForm = React.createClass({

  render: function() {

    return (
      <section className="form-container">
        <form className="form-group" id="new_vendor" action={"/landscaping_contracts/" + this.props.contract.id} method="post">
          <input type="hidden" name="_method" value="patch" />
          <input name="utf8" type="hidden" value="&#x2713;" />
          <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
          <input type="hidden" name="landscaping_contract[cover_sheet_entered]" value={true} />
          <label>Name</label>
          <input type="text" name="landscaping_contract[name]" defaultValue={this.props.contract.name}></input>
          <label>Old Annual Payment</label>
          <input type="number" name="landscaping_contract[old_annual_payment]"></input>
          <label>CPA Annual Payment</label>
          <input type="number" name="landscaping_contract[cpa_annual_payment]"></input>

          <label>QBO Customer</label>
          <select name="landscaping_contract[qbo_customer_id]">
            {this.props.customer_hashes.map((customer) =>
              <option value={customer.id}>{customer.name}</option>
            )}
          </select>

          <label>Rebate Percentage</label>
          <input type="number" name="landscaping_contract[rebate_percentage]" step="0.01" defaultValue=".05"/>

          <label>Contract Start Date</label>
          <input type="date" name="landscaping_contract[contract_start_date]"></input>
          <label>Contract End Date</label>
          <input type="date" name="landscaping_contract[contract_end_date]"></input>

          <label>BILLING Start Date</label>
          <input type="date" name="landscaping_contract[billing_start_date]"></input>
          <label>BILLING End Date</label>
          <input type="date" name="landscaping_contract[billing_end_date]"></input>

          <input type="submit" value="Add Cover Sheet" />
          </form>
      </section>
    )

  }

})
