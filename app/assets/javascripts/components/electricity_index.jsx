const ElectricityIndex = React.createClass({

  totalRebate: function() {
  },

  render: function() {

    return (
      <section>

        <table style={{ width: '90%', marginLeft: '5%', marginRight: '5%', fontSize: 18 }}>
          <thead>
            <tr>
              <th>Name:</th>
              <th>Start Date</th>
              <th>End Date</th>
              <th>Rebate to CPA</th>
              <th>CPA Price</th>
              <th>Total kwh</th>
              <th>Annual Rebate</th>
            </tr>
          </thead>
          <tbody>
            {this.props.contracts.map((contract) => {
                return <SingleElecRow
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
