const MemberHeader = React.createClass({

  formatPvr: function(pvr) {
    var pvrDecimal = pvr
    var pvrPercent = (pvrDecimal.toFixed(2)*100)
    return pvrPercent
  },

  sellList: function(sell_list) {
    var string = "Eligible for Contracts in: "
    for (i = 0; i < sell_list.length; i++) {
      string += sell_list[i] + ", ";
    }
    string = string.slice(0, -2);
    return string
  },

  render: function() {

    return (
      <section>
        <h1 style={{textAlign: 'left', marginBottom: 10, marginLeft: '5%', fontSize: 40}}>{this.props.member_data.name}</h1>
        <section style={{textAlign: 'left', marginBottom: 40, marginLeft: '5%', fontSize: 28}}>
          <section>PVR: {this.formatPvr(this.props.member_data.pvr)}%</section>
          <section>{this.props.member_data.institution_type}</section>
          <section>{this.props.member_data.city_state}</section>
          <section>{this.sellList(this.props.member_data.sell_list)}</section>

        </section>
      </section>
    )

  }

})
