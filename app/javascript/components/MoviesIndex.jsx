import React from "react";
import PropTypes from "prop-types";
import ReactTable from "react-table";
import "react-table/react-table.css";

class MoviesIndex extends React.Component {
  render() {
    return (
      <div>
        <ReactTable
          data={this.props.movies}
          defaultPageSize={5}
          columns={[
            {
              Header: "Title",
              accessor: "movie_title"
            }
          ]}
        />
      </div>
    );
  }
}

export default MoviesIndex;
