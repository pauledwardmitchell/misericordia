const ServiceAreaPipeline = React.createClass({

  render: function() {

    return (
      <section>
        <section>
          {this.props.contracts.map((contract) => {
              return <SingleContract
                       key={contract.id}
                       contract={contract}
                       contract_type={this.props.contract_type}/>
              }
          )}
        </section>
      </section>
    )

  }

})
