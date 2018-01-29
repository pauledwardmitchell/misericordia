const MembersIndex = React.createClass({

  render: function() {

    return (
      <section>
        {this.props.members.map((member) => {
            return <SingleMember
                     key={member.id}
                     member={member}/>
            }
        )}
      </section>
    )

  }

})
