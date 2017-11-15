const SingleContract = React.createClass({

  formattedDate: function(utc_date) {
    var date = new Date(utc_date)
    var day = date.getDate()
    var monthNumber = date.getMonth()
    var monthNames =  ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var month = monthNames[monthNumber]
    var year = date.getFullYear()

    return day + " " + month + " " + year
  },

  linkFromContractType: function() {
    switch (this.props.contract_type) {
    case "cleaning":
        return "/cleaning_contracts";
        break;
    case "copier":
        return "/copier_contracts";
        break;
    case "electricity":
        return "/electricity_contracts";
        break;
    case "general":
        return "/general_contracts";
        break;
    case "landscaping":
        return "/landscaping_contracts/";
        break;
    case "waste":
        return "/waste_contracts";
        break;
    case "solar":
        return "/solar_contracts";
        break;
    case "gas":
        return "/gas_contracts";
        break;
    case "security":
        return "/security_contracts";
        break;
    }
  },

  render: function() {

    return (
      <table style={{ width: '90%', marginLeft: '5%', marginRight: '5%', fontSize: 24 }}>
        <thead></thead>
        <tbody>
          <tr>
            <td><a href={this.linkFromContractType() + "/" + this.props.contract.id + "/edit"}>Add Cover Sheet</a></td>
            <td>{this.props.contract.name}</td>
            <td>Won on: {this.formattedDate(this.props.contract.created_at)}</td>
          </tr>
        </tbody>
      </table>
    )

  }

})
