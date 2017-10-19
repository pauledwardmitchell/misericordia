const CustomerProfile = React.createClass({

  render: function() {

    return (
      <section>
        <CustomerHeader customer={this.props.customer}/>

        <CustomerRebateTracker
          customer_invoices={this.props.customer_invoices}
          total_thirty={this.props.total_thirty}
          balance_thirty={this.props.balance_thirty}/>

      </section>
    )

  }

})
