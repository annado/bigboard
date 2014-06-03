App.Views.ProjectMembers = App.Views.ProjectMembers || {};

App.Views.ProjectMembers.New = Backbone.View.extend({

  template: JST['project_members/new'],

  className: "project-members-new",

  defaults: {
    role_id: null,
    project_id: null
  },

  events: {
    "submit #new_project_member": "save"
  },

  initialize: function (o) {
    this.role_id = o.role_id;
    this.project_id = o.project_id;
  },

  render: function () {
    $(this.el).html(this.template({ 
      role_id: this.role_id
    }));

    this.initTypeahead();
    return this;
  },

  save: function (e) {
    e.preventDefault();
    e.stopPropagation();
  },

  onTypeaheadSelect: function (e, o, name) {
    this.$el.find('input').attr("disabled", "disabled");
    this.model.project_members.create({
      role_id: this.role_id,
      project_id: this.model.id,
      person_id: o.id
    }, {
      wait : true,
      success : _.bind(this.onSuccess, this),
      error : function(err) {
        console.log('ProjectMembers.New error callback', err);
      }
    });

  },

  onSuccess: function (resp) {
    this.$el.trigger('close');
  },

  initTypeahead: function () {
    var $typeahead = this.$el.find('#bigboard-autocomplete .typeahead');
    App.typeahead.addPeopleTypeahead($typeahead, $.proxy(this.onTypeaheadSelect, this));
  }

});
