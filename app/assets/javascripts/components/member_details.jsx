const MemberDetails = React.createClass({

  formatMoneyNumber: function(number) {
    if (number === null) {
      return 0.00
    }   else {
          return Number(number.toFixed(2)).toLocaleString()
    }
  },

  render: function() {

    return (
      <section>
        <table style={{ width: '90%', marginLeft: '5%', marginRight: '5%', fontSize: 18 }}>
          <thead>
            <tr>
              <th>Name:</th>
              <th>Monthly Payment</th>
              <th>Monthly Savings</th>
              <th>Monthly Rebate</th>
              <th>Rebate Percentage</th>
              <th>Contract End Date</th>
            </tr>
          </thead>
          <tbody>
            {this.props.current_contract_data.map((contract) => {
                return <SingleContractRow
                         key={contract.id}
                         contract={contract}/>
                }
            )}
            <tr style={{fontWeight: 'bold', fontSize: 20}}>
              <td>Monthly Total / [Annual Total]</td>
              <td>${this.formatMoneyNumber(this.props.totals_data.monthly_payment_total)} / [${this.formatMoneyNumber(this.props.totals_data.monthly_payment_total*12)}]</td>
              <td>${this.formatMoneyNumber(this.props.totals_data.monthly_savings_total)} / [{this.formatMoneyNumber(this.props.totals_data.monthly_savings_total*12)}]</td>
              <td>${this.formatMoneyNumber(this.props.totals_data.monthly_rebate_total)} / [${this.formatMoneyNumber(this.props.totals_data.monthly_rebate_total*12)}]</td>
              <td></td>
              <td></td>
            </tr>
          </tbody>
        </table>
      </section>
    )

  }

})
