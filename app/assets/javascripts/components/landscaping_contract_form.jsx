const LandscapingContractForm = React.createClass({

  render: function() {

    return (
      <section>
        <form className="form-group" id="new_vendor" action="/landscaping_contracts" method="post">
          <input name="utf8" type="hidden" value="&#x2713;" />
          <input type='hidden' name='authenticity_token' value={this.props.authenticity_token} />
          <input type="hidden" name="_method" value="put" />
          <label>Name</label>
          <input type="text" name="landscaping_contract[name]" id="vendor_name" defaultValue={this.props.contract.name}></input>
          <input type="integer" name="landscaping_contract[old_annual_payment"/>
          <input type="submit" value="Submit Vendor" />
          </form>
      </section>
    )

  }

})
