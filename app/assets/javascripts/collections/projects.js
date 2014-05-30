BigBoard.Collections.Projects = Backbone.Collection.extend({

  model: BigBoard.Models.Project,

  initialize: function (model, options) {
    this.board_id = options.board_id
    this.initiative_id = options.initiative_id;
  },

  url: function () {
    return '/board/' + this.board_id + '/projects';
  }

});
