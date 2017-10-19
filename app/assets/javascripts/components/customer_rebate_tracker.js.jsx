const CustomerRebateTracker = React.createClass({

  lastMonthNumber: function() {
    var now = Date.now()
    var date = new Date(now)
    var month = date.getMonth() //zero indexed, so this gives last month

    return month
  },

  currentMonthNumber: function() {
    var currentMonthNumber = this.lastMonthNumber() + 1
    return currentMonthNumber
  },

  lastMonthName: function() {
    var monthNumber = this.lastMonthNumber()
    var monthNames = ["January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December"];

    return monthNames[monthNumber]
  },

  lastQuarter: function() {
    switch(this.currentMonthNumber()) {
      case 1:
      case 2:
      case 3:
          return "Q4"
          break;
      case 4:
      case 5:
      case 6:
          return "Q1"
          break;
      case 7:
      case 8:
      case 9:
          return "Q2"
          break;
      case 10:
      case 11:
      case 12:
          return "Q3"
          break;
    }
  },

  currentYear: function() {
    var now = Date.now()
    var date = new Date(now)
    var year = date.getFullYear()

    return year
  },

  render: function() {

    return (
      <section>
        <table>
          <thead>
            <tr>
              <th>Time Period</th>
              <th>Amount Owed</th>
              <th>Amount Paid</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Last 30 days: </td>
              <td>{this.props.total_thirty}</td>
              <td>{this.props.balance_thirty}</td>
            </tr>
            <tr>
              <td>Last Quarter ({this.lastQuarter()}):</td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>Year to Date ({this.currentYear()}):</td>
              <td></td>
              <td></td>
            </tr>
          </tbody>
        </table>
      </section>
    )

  }

})
