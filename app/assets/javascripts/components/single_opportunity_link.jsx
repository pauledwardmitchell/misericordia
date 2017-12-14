const SingleOpportunityLink = React.createClass({

  render: function() {

    return (
      <section>
        <a href={"https://app.prosperworks.com/companies/50272/app#/deal/" + this.props.opportunity.id} target="_blank">{this.props.opportunity.name + ": " + this.props.opportunity.status}</a>
      </section>
    )

  }

})
