App.Models.Project = Backbone.Model.extend({

  paramRoot: 'project',

  defaults: {
    initiative_id: null
  },

  initialize: function (options) {
    this.project_members = new App.Collections.ProjectMembers(
      options.project_members, { project_id: this.id }
    );
  }

});
