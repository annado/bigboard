BigBoard.Models.Project = Backbone.Model.extend({

  paramRoot: 'project',

  defaults: {
    initiative_id: null
  },

  initialize: function (options) {
    this.project_members = new BigBoard.Collections.ProjectMembers(
      options.project_members, { project_id: this.id }
    );
  }

});
