App.Routers.Boards = Backbone.Router.extend({
  
  initialize: function (options) {
    this.board = new App.Models.Board(options.board);
    App.typeahead = new App.Views.PeopleTypeahead({
      board_id: options.board.id
    });
    App.collections.teams = new App.Collections.Teams(options.teams, {
      board_id: options.board.id
    });
  },

  routes: {
    ".*" : "show"
  },

  show: function () {
    this.view = new App.Views.BoardsIndex({model: this.board, id: '#board-table'});
    this.view.render()
  }

});
