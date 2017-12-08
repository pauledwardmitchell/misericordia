const BigRebateTracker = React.createClass({

  formatMoneyNumber: function(number) {
    if (number === null) {
      return 0.00
    }  else {
      return Number(number.toFixed(2)).toLocaleString()
    }
  },

  percentOfTotal: function(number) {
    return ((number / this.props.totals_data.total_revenue) * 100).toFixed(2)
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
                         total={this.props.totals_data.total_revenue}/>
                }
            )}

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>ANNUAL TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.total_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.total_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>ELECTRICITY TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.electricity_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.electricity_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>GAS TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.gas_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.gas_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>CLEANING TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.cleaning_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.cleaning_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>LANDSCAPING TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.landscaping_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.landscaping_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>SECURITY TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.security_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.security_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>TRASH HAULING TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.waste_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.waste_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>COPIER TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.copier_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.copier_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>SOLAR TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.solar_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.solar_revenue)}</td>
            </tr>

            <tr style={{ fontWeight: 'bold', fontSize: 20 }} >
              <td>MISC. TOTAL</td>
              <td>$ {this.formatMoneyNumber(this.props.totals_data.misc_revenue)}</td>
              <td>{this.percentOfTotal(this.props.totals_data.misc_revenue)}</td>
            </tr>

          </tbody>
        </table>
      </section>
    )

  }

})
