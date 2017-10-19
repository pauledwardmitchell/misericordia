const CustomerProfile = React.createClass({

  render: function() {

    return (
      <section>
        <CustomerHeader customer={this.props.customer}/>

        <CustomerRebateTracker data={this.props.data}/>

      </section>
    )

  }

})
