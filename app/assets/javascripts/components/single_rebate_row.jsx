const SingleRebateRow = React.createClass({

  render: function() {

    return (
      <tr>
        <td>{this.props.org.name}</td>
        <td>${this.props.org.revenue}</td>
        <td>-</td>
      </tr>
    )

  }

})
