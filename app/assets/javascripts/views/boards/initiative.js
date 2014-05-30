BigBoard.Views.Initiative = Backbone.View.extend({

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
    var view = new BigBoard.Views.Project({model : project, el: el});
    view.render();
  }

});
