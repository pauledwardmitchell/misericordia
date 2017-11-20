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

        <h2 style={{marginLeft: '10%'}}>Cleaning Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.cleaning_contracts}
          contract_type="cleaning"/>

        <h2 style={{marginLeft: '10%'}}>Security Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.security_contracts}
          contract_type="security"/>

        <h2 style={{marginLeft: '10%'}}>Copier Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.copier_contracts}
          contract_type="copier"/>

        <h2 style={{marginLeft: '10%'}}>Solar Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.solar_contracts}
          contract_type="solar"/>

        <h2 style={{marginLeft: '10%'}}>Gas Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.gas_contracts}
          contract_type="gas"/>

        <h2 style={{marginLeft: '10%'}}>Electricity Contracts</h2>
        <ServiceAreaPipeline
          contracts={this.props.electricity_contracts}
          contract_type="electricity"/>

      </section>
    )

  }

})
