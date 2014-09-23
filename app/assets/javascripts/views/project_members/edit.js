App.Views.ProjectMembers = App.Views.ProjectMembers || {};

App.Views.ProjectMembers.Edit = Backbone.View.extend({

  template: JST['project_members/edit'],

  className: "project-members-edit",

  events: {
    "submit .edit_project_member": "save"
  },

  initialize: function (o) {
  },

  render: function () {
    var person = this.model.attributes.person,
      team = App.collections.teams.findWhere({
        id: person && person.team_id || ''
      });

    if (!!person) {
      $(this.el).html(this.template({ 
        person: person,
        project_member: this.model.attributes,
        team: team.attributes,
        location: person.location && person.location.name
      }));

      this.$startdate = this.$el.find('#project_member_start_date');
      this.$enddate = this.$el.find('#project_member_end_date');
      this.$submit = this.$el.find('input.btn');
    }

    return this;
  },

  save: function (e) {
    e.preventDefault();
    e.stopPropagation();

    this.loading();
    this.update();
  },

  loading: function () {
    this.$submit.button('loading');
  },

  update: function () {
    var startDate = this.$startdate.val(),
      endDate = this.$enddate.val();

    this.model.save({
      'start_date': startDate,
      'end_date': endDate
    }, {
      patch : true,
      wait : true,
      success : _.bind(this.onSuccess, this),
      error : function(err) {
        console.log('ProjectMembers.Edit error callback', err);
      }
    });
  },

  close: function () {
    this.$el.trigger('close');
  },

  onSuccess: function (resp) {
    this.close();
    this.$submit.button('reset');
  }

});
