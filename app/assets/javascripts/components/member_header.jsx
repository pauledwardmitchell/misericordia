const MemberHeader = React.createClass({

  formatPvr: function(pvr) {
    var pvrDecimal = pvr
    var pvrPercent = (pvrDecimal.toFixed(2)*100)
    return pvrPercent
  },

  render: function() {

    return (
      <section>
        <h1 style={{textAlign: 'left', marginBottom: 10, marginLeft: '5%', fontSize: 40}}>{this.props.member_data.name}</h1>
        <section style={{textAlign: 'left', marginBottom: 40, marginLeft: '5%', fontSize: 28}}>
          <section>PVR: {this.formatPvr(this.props.member_data.pvr)}%</section>

        </section>
      </section>
    )

  }

})
