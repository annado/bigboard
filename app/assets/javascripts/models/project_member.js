App.Models.ProjectMember = Backbone.Model.extend({

  paramRoot: 'project_member',

  defaults: {
    role_id: null,
    project_id: null,
    person_id: null,
    end_date: null,
    start_date: null
  },

  url: function () {
    return '/project_members/' + this.attributes.id;
  }

  
});
