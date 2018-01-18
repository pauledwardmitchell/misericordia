const GlobalSearch = React.createClass({

  getInitialState: function() {
    return {
      searchText: ''
    }
  },

  handleChange: function(event) {
    this.setState({searchText: event.target.value});
  },

  render: function() {

    let customerBox
    if (this.state.searchText.length > 1) {
      customerBox = <div><GlobalSearchBox customerName={this.state.searchText} customers={this.props.customers} /></div>
    } else {
      customerBox = <div></div>
    }

    return (
      <span>
        <input onChange={this.handleChange} type="text" />
        {customerBox}
      </span>
    )

  }

})
