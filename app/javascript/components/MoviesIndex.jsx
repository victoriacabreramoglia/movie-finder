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
            },
            {
              Header: "Plot",
              accessor: "movie.Plot"
            },
            {
              Header: "Poster",
              accessor: "movie.Poster",
              Cell: row => <img src={`${row.value}`} />
            }
          ]}
        />
      </div>
    );
  }
}

export default MoviesIndex;
