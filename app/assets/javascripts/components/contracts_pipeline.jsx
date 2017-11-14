const ContractsPipeline = React.createClass({

  render: function() {

    return (
      <section>
        <h1 style={{textAlign: 'center', marginBottom: 40, fontSize: 40}}>Enter coversheets for the following contracts:</h1>
        <h2 style={{marginLeft: '10%'}}>Landscaping Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.landscaping_contracts}
          contract_type="landscaping"/>

        <h2 style={{marginLeft: '10%'}}>Waste Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.waste_contracts}
          contract_type="waste"/>

      </section>
    )

  }

})
