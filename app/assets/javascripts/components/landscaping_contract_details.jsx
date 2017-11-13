const LandscapingContractDetails = React.createClass({

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
              <td>{this.props.contract.contract_start_date}</td>
              <td>{this.props.contract.contract_end_date}</td>
            </tr>
          </tbody>
        </table>

        <a href={"/landscaping_contracts/" + this.props.contract.id + "/edit"}>Edit this contract</a>

      </section>
    )

  }

})
