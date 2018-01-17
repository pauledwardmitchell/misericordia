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
        return "Landscaping Contract";
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

  // linkFromContractType: function() {
  //   switch (this.props.contract_type) {
  //   case "cleaning":
  //       return "/cleaning_contracts";
  //       break;
  //   case "copier":
  //       return "/copier_contracts";
  //       break;
  //   case "electricity":
  //       return "/electricity_contracts";
  //       break;
  //   case "general":
  //       return "/general_contracts";
  //       break;
  //   case "landscaping":
  //       return "/landscaping_contracts/";
  //       break;
  //   case "waste":
  //       return "/waste_contracts";
  //       break;
  //   case "solar":
  //       return "/solar_contracts";
  //       break;
  //   case "gas":
  //       return "/gas_contracts";
  //       break;
  //   case "security":
  //       return "/security_contracts";
  //       break;
  //   }
  // },

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
      return ((rebate_percentage*100).toFixed(4)) + "%"
    }
  },

  rowClass: function(end_date) {
    var sixtyDaysFromNow = new Date().getTime() + (60 * 24 * 60 * 60 * 1000)
    var contractEndDate = new Date(end_date).getTime()
    if (contractEndDate < sixtyDaysFromNow) {
      return "date-alert"
    } else {
      return ""
    }
  },

  render: function() {

    return (
      <tr className={this.rowClass(this.props.contract.end_date)}>
        <td>{this.props.contract.name}</td>
        <td>{this.monthlyPayment(this.props.contract.monthly_payment)}</td>
        <td>${this.formatMoneyNumber(this.props.contract.monthly_savings)}</td>
        <td>${this.formatMoneyNumber(this.props.contract.monthly_rebate)}</td>
        <td>{this.rebatePercentage(this.props.contract.rebate_percentage)}</td>
        <td>{this.props.contract.end_date}</td>
      </tr>
    )

  }

})
