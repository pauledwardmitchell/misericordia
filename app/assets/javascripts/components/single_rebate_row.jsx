const SingleRebateRow = React.createClass({

  render: function() {

    return (
      <tr>
        <td>{this.props.org.name}</td>
        <td>Won on: {this.props.org.revenue}</td>
      </tr>
    )

  }

})
