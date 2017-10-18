const CustomerHeader = React.createClass({

  render: function() {

    return (
      <section>
        <h2>{this.props.customer.displayname}</h2>
      </section>
    )

  }

})
