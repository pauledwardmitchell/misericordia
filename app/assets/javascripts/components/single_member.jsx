const SingleMember = React.createClass({

  render: function() {

    return (
      <section>
        <a href={"/members/"+this.props.member.id}>{this.props.member.name}</a>
      </section>
    )

  }

})
