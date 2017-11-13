const LandscapingPipeline = React.createClass({

  render: function() {

    return (
      <section>
        <h2>Landscaping Contracts</h2>
        <section>
          {this.props.landscaping_contracts.map((contract) => {
              return <SingleContract
                       key={contract.id}
                       contract={contract}
                       contract_type="landscaping"/>
              }
          )}
        </section>
      </section>
    )

  }

})
