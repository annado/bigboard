App.Models.ProjectMember = Backbone.Model.extend({

  paramRoot: 'project_member',

  defaults: {
    role_id: null,
    project_id: null,
    person_id: null
  }
  
});
