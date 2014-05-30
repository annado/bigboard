BigBoard.Collections.Teams = Backbone.Collection.extend({

  model: BigBoard.Models.Team,

  initialize: function (model, options) {
  },

  url: function () {
    return '/board/' + this.board_id + '/teams';
  }

});
