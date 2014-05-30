BigBoard.Routers.Boards = Backbone.Router.extend({
  
  initialize: function (options) {
    this.board = new BigBoard.Models.Board(options.board);
    BigBoard.typeahead = new BigBoard.Views.PeopleTypeahead({
      board_id: options.board.id
    });
    BigBoard.collections.teams = new BigBoard.Collections.Teams(options.teams, {
      board_id: options.board.id
    });
  },

  routes: {
    ".*" : "show"
  },

  show: function () {
    this.view = new BigBoard.Views.BoardsIndex({model: this.board, id: '#board-table'});
    this.view.render()
  }

});
