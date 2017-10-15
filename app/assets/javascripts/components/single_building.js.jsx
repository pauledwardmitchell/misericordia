const SingleBuilding = React.createClass({

  render: function() {

    return (
      <section>
        <section>BUILDING: {this.props.building.street_address} / {this.props.building.city}, {this.props.building.state} {this.props.building.zip}</section>
      </section>
    )

  }

})
