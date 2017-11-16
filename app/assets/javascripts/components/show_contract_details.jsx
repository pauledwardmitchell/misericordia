const ShowContractDetails = React.createClass({

  formattedDate: function(utc_date) {
    var date = new Date(utc_date)
    var day = date.getUTCDate()
    var monthNumber = date.getUTCMonth()
    var monthNames =  ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var month = monthNames[monthNumber]
    var year = date.getUTCFullYear()

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
      <section>
        <table style={{ width: '80%', marginLeft: '10%', marginRight: '10%', fontSize: 24, textAlign: 'center' }}>
          <thead>
            <tr>
              <th>Contract #</th>
              <th>Name</th>
              <th>Start Date</th>
              <th>End Date</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>{this.props.contract.id}</td>
              <td>{this.props.contract.name}</td>
              <td>{this.formattedDate(this.props.contract.contract_start_date)}</td>
              <td>{this.formattedDate(this.props.contract.contract_end_date)}</td>
            </tr>
          </tbody>
        </table>

        <a href={this.linkFromContractType() + "/" + this.props.contract.id + "/edit"}>Edit this contract</a>

      </section>
    )

  }

})
