const ContactBoxes = React.createClass({

  render: function() {

    return (
      <section>
        {this.props.contacts.map((contact) => {
            return <SingleContact
                     key={contact.id}
                     contact={contact}/>
            }
        )}
      </section>
    )

  }

})
