const BigRebateTracker = React.createClass({

  render: function() {

    return (
      <section>

        <table style={{ width: '90%', marginLeft: '5%', marginRight: '5%', fontSize: 18 }}>
          <thead>
            <tr>
              <th>Organization:</th>
              <th>Rebate Generated to CPA</th>
              <th>Year End Check Amount</th>
            </tr>
          </thead>
          <tbody>
            {this.props.data.map((org) => {
                return <SingleRebateRow
                         key={org.id}
                         org={org}/>
                }
            )}
          </tbody>
        </table>
      </section>
    )

  }

})
