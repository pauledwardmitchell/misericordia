const CustomerHeader = React.createClass({

  render: function() {

    return (
      <section>
        <h2>{this.props.customer.display_name}</h2>
      </section>
    )

  }

})
