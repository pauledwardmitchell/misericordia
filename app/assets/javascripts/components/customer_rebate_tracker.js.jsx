const CustomerRebateTracker = React.createClass({

  lastMonth: function() {

  },

  lastQuarter: function() {

  },

  currentYear: function() {

  },

  render: function() {

    return (
      <section>
        <table>
          <tr>
            <th>Time Period</th>
            <th>Amount Owed</th>
            <th>Amount Paid</th>
          </tr>
          <tr>
            <td>Last Month: {this.lastMonth()}</td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td>Last Quarter: {this.lastQuarter()}</td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td>Year to Date: {this.currentYear()}</td>
            <td></td>
            <td></td>
          </tr>
        </table>
      </section>
    )

  }

})
