const LandscapingContractDetails = React.createClass({

  render: function() {

    return (
      <section>
        <h2>Landscaping Contract:</h2>
        <section>Name: {this.props.contract.name}</section>
        <section>CONTRACT ID: {this.props.contract.id}</section>
        <section>Contract Dates: {this.props.contract.contract_start_date} to {this.props.contract.contract_end_date}</section>

        <a href={"/landscaping_contracts/" + this.props.contract.id + "/edit"}>Edit this contract</a>

      </section>
    )

  }

})
