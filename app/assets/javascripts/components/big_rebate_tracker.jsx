const BigRebateTracker = React.createClass({

  formatMoneyNumber: function(number) {
    if (number === null) {
      return 0.00
    }  else {
      return Number(number.toFixed(2)).toLocaleString()
    }
  },

  render: function() {

    return (
      <section>

        <table style={{ width: '90%', marginLeft: '5%', marginRight: '5%', fontSize: 18 }}>
          <thead>
            <tr>
              <th>Organization:</th>
              <th>Rebate Generated to CPA</th>
              <th>Percent of total</th>
            </tr>
          </thead>
          <tbody>
            {this.props.data.map((org) => {
                return <SingleRebateRow
                         key={org.id}
                         org={org}
                         total={this.props.total_revenue}/>
                }
            )}
            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>ANNUAL TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.total_revenue)}</td>
              <td>-</td>
            </tr>
          </tbody>
        </table>
      </section>
    )

  }

})
