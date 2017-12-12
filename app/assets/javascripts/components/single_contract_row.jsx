const SingleContractRow = React.createClass({

  nameFromContractType: function() {
    switch (this.props.contract.contract_type) {
    case "CleaningContract":
        return "Cleaning Contract";
        break;
    case "CopierContract":
        return "Copier Contract";
        break;
    case "ElectricityContract":
        return "Electricity Contract";
        break;
    case "MonthlyContract":
        return "General Contract";
        break;
    case "LandscapingContract":
        return "Lanscaping Contract";
        break;
    case "WasteContract":
        return "Waste Contract";
        break;
    case "SolarContract":
        return "Solar Contract";
        break;
    case "GasContract":
        return "Gas Contract";
        break;
    case "SecurityContract":
        return "Security Contract";
        break;
    }
  },

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

  monthlyPayment: function(monthly_payment) {
    if (monthly_payment === 0) {
      return "-"
    } else {
      return "$" + this.formatMoneyNumber(monthly_payment)
    }
  },

  rebatePercentage: function(rebate_percentage) {
    if (rebate_percentage === 0) {
      return "-"
    } else {
      return (rebate_percentage*100) + "%"
    }
  },

  render: function() {

    return (
      <tr>
        <td>{this.nameFromContractType()}</td>
        <td>{this.monthlyPayment(this.props.contract.monthly_payment)}</td>
        <td>${this.formatMoneyNumber(this.props.contract.monthly_savings)}</td>
        <td>${this.formatMoneyNumber(this.props.contract.monthly_rebate)}</td>
        <td>{this.rebatePercentage(this.props.contract.rebate_percentage)}</td>
        <td>{this.props.contract.end_date}</td>
      </tr>
    )

  }

})
