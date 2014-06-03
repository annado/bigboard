App.Collections.ProjectMembers = Backbone.Collection.extend({

  model: App.Models.ProjectMember,

  initialize: function (model, options) {
    this.project_id = options.project_id;
  },

  render: function () {
    this.el = $('[data-project-member-id=' + this.id + ']');
    return this;
  },

  url: function () {
    return '/projects/' + this.project_id + '/project_members';
  }

});
