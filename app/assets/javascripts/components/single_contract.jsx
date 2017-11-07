const SingleContract = React.createClass({

  render: function() {

    return (
      <section>
        <section>{this.props.contract.name}</section>
        <section>{this.props.contract.created_at}</section>
        <a href={"/landscaping_contracts/" + this.props.contract.id + "/edit"}>Add Cover Sheet</a>
      </section>
    )

  }

})
