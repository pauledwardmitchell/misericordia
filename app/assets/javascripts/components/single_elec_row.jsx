const SingleElecRow = React.createClass({

  formatMoneyNumber: function(number) {
    if (number === null) {
      return 0.00
}   else {
      return Number(number.toFixed(2)).toLocaleString()
}
  },

  percentOfTotal: function() {
    return ((this.props.org.revenue / this.props.total) * 100).toFixed(2)
  },

  render: function() {

    return (
      <tr>
        <td>{this.props.contract.name}</td>
        <td>{this.props.contract.contract_start_date}</td>
        <td>{this.props.contract.contract_end_date}</td>
        <td>{this.props.contract.rebate_to_cpa}</td>
        <td>{this.props.contract.cpa_negotiated_price}</td>
        <td>{this.props.contract.total_kwh_expected}</td>
        <td>$ {this.formatMoneyNumber(this.props.contract.annual_rebate)}</td>
      </tr>
    )

  }

})
