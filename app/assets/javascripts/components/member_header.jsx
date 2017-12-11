const MemberHeader = React.createClass({

  render: function() {

    return (
      <section>
        <h1 style={{textAlign: 'center', marginBottom: 40, fontSize: 40}}>{this.props.member_data.name}</h1>
      </section>
    )

  }

})
