const MemberShow = React.createClass({

  render: function() {

    return (
      <section>
        <MemberHeader member_data={this.props.member_data}/>
        <MemberDetails current_contract_data={this.props.current_contract_data}/>
      </section>
    )

  }

})
