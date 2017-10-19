const CustomerHeader = React.createClass({

  render: function() {

    return (
      <section>
        <h1 style={{textAlign: 'center', marginBottom: 40, fontSize: 40}}>{this.props.customer.display_name}</h1>
      </section>
    )

  }

})
