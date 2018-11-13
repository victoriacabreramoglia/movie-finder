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
              id: "id",
              Cell: d => (
                <a href={`/movie/show?review_id=${d.id}`}>{d.movie_title}</a>
              )
            },
            {
              Header: "Plot",
              accessor: "movie.Plot"
            },
            {
              Header: "Poster",
              accessor: "movie.Poster",
              Cell: row => (
                <img class="index-movie-poster" src={`${row.value}`} />
              )
            }
          ]}
        />
      </div>
    );
  }
}

export default MoviesIndex;
