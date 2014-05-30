BigBoard.Collections.Initiatives = Backbone.Collection.extend({

  model: BigBoard.Models.Initiative,

  initialize: function (model, options) {
    this.board_id = options.board_id;
  },

  url: function () {
    return '/board/' + this.board_id + '/initiatives';
  }

});
