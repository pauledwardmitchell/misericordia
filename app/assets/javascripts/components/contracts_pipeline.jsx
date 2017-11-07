const ContractsPipeline = React.createClass({

  render: function() {

    return (
      <section>
        <h1 style={{textAlign: 'center', marginBottom: 40, fontSize: 40}}>Enter coversheets for the following contracts:</h1>
        <LandscapingPipeline landscaping_contracts={this.props.landscaping_contracts}/>

      </section>
    )

  }

})
