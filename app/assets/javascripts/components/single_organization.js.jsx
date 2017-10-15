const SingleOrganization = React.createClass({

  render: function() {

    return (
      <section>
        <h3>Legal Name: {this.props.organization.legal_name}</h3>
        <h3>Common Name: {this.props.organization.common_name}</h3>
        <section>Primary Address: {this.props.organization.primary_building_address.street_address} / {this.props.organization.primary_building_address.city}, {this.props.organization.primary_building_address.state} {this.props.organization.primary_building_address.zip}</section>

        <section>
          {this.props.organization.all_buildings.map((building) => {
              return <SingleBuilding
                       key={building.id}
                       building={building}/>
              }
          )}
        </section>
        <h1>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - </h1>
      </section>
    )

  }

})
