App.Views.Initiative = Backbone.View.extend({

  events: {
  },

  initialize: function (o) {
    this.addAll();
  },

  addAll: function () {
    this.model.projects.each(this.addOne, this);
  },

  addOne: function (project) {
    var el = this.$el.find('tr[data-project-id=' + project.id + ']');
    var view = new App.Views.Project({model : project, el: el});
    view.render();
  }

});
