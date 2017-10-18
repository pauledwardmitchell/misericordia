const CustomerProfile = React.createClass({

  render: function() {

    return (
      <section>
        <CustomerHeader customer={this.props.customer}/>

        <CustomerRebateTracker customer_invoices={this.props.customer_invoices}/>

      </section>
    )

  }

})
