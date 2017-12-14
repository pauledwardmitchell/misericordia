const MemberOpportunitiesTracker = React.createClass({

  sellList: function(sell_list) {
    var string = ""
    for (i = 0; i < sell_list.length; i++) {
      string += sell_list[i] + ", ";
    }
    string = string.slice(0, -2);
    return string
  },

  render: function() {

    return (
      <section>
        <div style={{ width: '20%', marginLeft: '5%', marginRight: '1%', fontSize: 18, float: 'left', border: '1px', borderStyle: 'solid', padding: 20 }}>
          <h4>Eligible for contracts in: </h4>
          {this.props.member_data.sell_list.map((category) => {
              return <section>{category}</section>
            }
          )}
        </div>
        <div style={{ width: '30%', marginLeft: '1%', marginRight: '5%', fontSize: 18, float: 'left', border: '1px', borderStyle: 'solid', padding: 10 }}>
          <h4>Opportunities in ProsperWorks: </h4>
          {this.props.member_data.opportunities.map((opportunity) => {
              return <SingleOpportunityLink
                       key={opportunity.id}
                       opportunity={opportunity}/>
              }
          )}
        </div>
      </section>
    )

  }

})
