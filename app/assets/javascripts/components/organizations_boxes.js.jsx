const OrganizationsBoxes = React.createClass({

  render: function() {

    return (
      <section>
        {this.props.organizations.map((organization) => {
            return <SingleOrganization
                     key={organization.id}
                     organization={organization}/>
            }
        )}
      </section>
    )

  }

})
