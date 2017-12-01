const SingleRebateRow = React.createClass({

  formatMoneyNumber: function(number) {
    if (number === null) {
      return 0.00
}   else {
      return Number(number.toFixed(2)).toLocaleString()
}
  },

  render: function() {

    return (
      <tr>
        <td>{this.props.org.name}</td>
        <td>$ {this.formatMoneyNumber(this.props.org.revenue)}</td>
        <td>-</td>
      </tr>
    )

  }

})
