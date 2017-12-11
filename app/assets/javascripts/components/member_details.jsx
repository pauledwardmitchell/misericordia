const MemberDetails = React.createClass({

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
          </tbody>
        </table>
      </section>
    )

  }

})
