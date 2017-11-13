const SingleContract = React.createClass({

  linkFromContractType: function() {
    switch (this.props.contract_type) {
    case "landscaping":
        return "/landscaping_contracts/";
        break;
    case "trash":
        return ;
        break;
    case 2:
        day = "Tuesday";
        break;
    case 3:
        day = "Wednesday";
        break;
    case 4:
        day = "Thursday";
        break;
    case 5:
        day = "Friday";
        break;
    default:
        return "";
        break;
    }
  },

  render: function() {

    return (
      <section>
        <section>{this.props.contract.name}</section>
        <section>{this.props.contract.created_at}</section>
        <a href={this.linkFromContractType() + this.props.contract.id + "/edit"}>Add Cover Sheet</a>
      </section>
    )

  }

})
