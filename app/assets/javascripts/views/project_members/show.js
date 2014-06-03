App.Views.ProjectMember = Backbone.View.extend({

  popoverTemplate: JST['project_members/popover'],
  template: JST['project_members/show'],
  tagName: 'li',

  events: {
  },

  initialize: function (o) {
    if (o.el) {
      this.created = true;
    }
  },

  render: function () {
    this.delegateEvents();

    var person = this.model.attributes.person,
      team = App.collections.teams.findWhere({
          id: person.team_id || ''
        });

    if (!this.created) {
      $(this.el).html(this.template({
        person: person,
        id: this.model.attributes.id
      }));
    }
    
    this.$el.popover({ 
      placement: 'bottom', 
      trigger: 'hover', 
      html: true,
      content: _.bind(function () {
        return this.popoverTemplate({
          project_member: this.model.attributes,
          person: person,
          team: team.attributes
        });
      }, this)
    });
    return this;
  }
});
