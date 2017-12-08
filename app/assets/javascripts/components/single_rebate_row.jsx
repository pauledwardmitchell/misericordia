const SingleRebateRow = React.createClass({

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
        <td>{this.props.org.name}</td>
        <td className="tooltip">$ {this.formatMoneyNumber(this.props.org.revenue)}
          <span className="tooltiptext">
            <section>{this.props.org.name}</section>
            <section>Landscaping: ${this.formatMoneyNumber(this.props.org.totals.landscaping_revenue)}</section>
            <section>Electricity: ${this.formatMoneyNumber(this.props.org.totals.electricity_revenue)}</section>
            <section>Gas: ${this.formatMoneyNumber(this.props.org.totals.gas_revenue)}</section>
            <section>Cleaning: ${this.formatMoneyNumber(this.props.org.totals.cleaning_revenue)}</section>
            <section>Security: ${this.formatMoneyNumber(this.props.org.totals.security_revenue)}</section>
            <section>Waste: ${this.formatMoneyNumber(this.props.org.totals.waste_revenue)}</section>
            <section>Solar: ${this.formatMoneyNumber(this.props.org.totals.solar_revenue)}</section>
            <section>Copier: ${this.formatMoneyNumber(this.props.org.totals.copier_revenue)}</section>
          </span>
        </td>
        <td>{this.percentOfTotal()}%</td>
      </tr>
    )

  }

})
