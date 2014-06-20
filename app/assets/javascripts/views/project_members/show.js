App.Views.ProjectMember = Backbone.View.extend({

  popoverTemplate: JST['project_members/popover'],
  template: JST['project_members/show'],
  tagName: 'li',

  events: {
    'click': 'showEditModal',
    'close': 'clearPopovers'
  },

  initialize: function (o) {
    if (o.el) {
      this.created = true;
    }
  },

  render: function () {
    this.delegateEvents();

    var person = this.model.attributes.person || '';

    if (!this.created) {
      $(this.el).html(this.template({
        person: person,
        id: this.model.attributes.id
      }));
    }

    this.popover = new App.Views.ProjectMembers.Edit({ model : this.model });
    this.popover.render();
    this.popover.$el.on('close', _.bind(this.clearPopovers, this));

    this.$el.popover({ 
      placement: 'bottom', 
      trigger: 'click', 
      html: true,
      title: function () {
        $title = 'Edit Project Member';
        return $title;
      },
      content: _.bind(function () {
        return this.popover.$el;
      }, this)
    });

    return this;
  },

  showEditModal: function (e) {
    e.preventDefault();
  },

  clearPopovers: function () {
    this.$el.popover('hide');
  }

});
