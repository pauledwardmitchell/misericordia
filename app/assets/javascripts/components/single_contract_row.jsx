const SingleContractRow = React.createClass({

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
        <td>${this.formatMoneyNumber(this.props.contract.monthly_payment)}</td>
        <td>${this.formatMoneyNumber(this.props.contract.monthly_savings)}</td>
        <td>${this.formatMoneyNumber(this.props.contract.monthly_rebate)}</td>
        <td></td>
        <td>{this.props.contract.end_date}</td>
      </tr>
    )

  }

})
