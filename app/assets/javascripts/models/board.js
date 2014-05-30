BigBoard.Models.Board = Backbone.Model.extend({

  paramRoot: 'board',

  defaults: {
    name: null
  },

  initialize: function (board) {
    this.board = board;
    this.initiatives = new BigBoard.Collections.Initiatives(
      this.board.initiatives, 
      { 
        board_id: this.board.id
      }
    );
    this.collection = this.initiatives;

  }

});
