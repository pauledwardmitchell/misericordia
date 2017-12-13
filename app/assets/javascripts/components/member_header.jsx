const MemberHeader = React.createClass({

  render: function() {

    return (
      <section>
        <h1 style={{textAlign: 'left', marginBottom: 10, marginLeft: '5%', fontSize: 40}}>{this.props.member_data.name}</h1>
        <section style={{textAlign: 'left', marginBottom: 40, marginLeft: '5%', fontSize: 20}}>
          PVR: {this.props.member_data.pvr}
        </section>
      </section>
    )

  }

})
