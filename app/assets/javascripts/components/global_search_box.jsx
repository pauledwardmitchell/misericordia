const GlobalSearchBox = React.createClass({

  render: function() {

    return (
      <ul>
        {this.props.customers
          .filter((customer) => `${customer.display_name}`.toUpperCase().indexOf(this.props.customerName.toUpperCase()) >= 0)
          .map((customer) => {
            return (
              <li key={customer.id}><a href={`/customers/${customer.id}`}>{customer.display_name}</a></li>
            )
          })}
      </ul>
    )

  }

})
