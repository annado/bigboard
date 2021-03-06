App.Models.Initiative = Backbone.Model.extend({

  paramRoot: 'initiative',

  defaults: {
    initiative_id: null
  },

  initialize: function (options) {
    this.projects = new App.Collections.Projects(
      options.projects, { 
        initiative_id: this.id,
        board_id: this.board_id
      }
    );
  }

});
