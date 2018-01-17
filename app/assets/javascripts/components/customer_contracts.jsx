const CustomerContracts = React.createClass({

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
        <table style={{ width: '90%', marginLeft: '5%', marginRight: '5%', marginBottom: 50, fontSize: 18 }}>
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
            {this.props.contracts.map((contract) => {
                return <SingleContractRow
                         key={contract.id}
                         contract={contract}/>
                }
            )}
          </tbody>
        </table>
      </section>
    )

  }

})
