const SingleContact = React.createClass({

  render: function() {

    return (
      <section>
        <h3>{this.props.contact.first_name} {this.props.contact.last_name}</h3>
        <section>Organization: {this.props.contact.organization_name}</section>
        <section>Email: {this.props.contact.email}</section>
        <section>Cell Phone: {this.props.contact.cell_phone}</section>
        <section>Work Phone: {this.props.contact.office_phone}</section>
        <section>Address of Organization Primary Building: {this.props.contact.physical_address.street_address}</section>


      </section>
    )

  }

})
