App.Views.BoardsIndex = Backbone.View.extend({

  template: JST['boards/index'],

  events: {
    "click .add-person": "addProjectMember",
  },

  initialize: function (o) {
  },

  render: function () {
    this.el = $(this.id);
    this.addAll();
    return this;
  },

  addAll: function () {
    this.model.initiatives.each(this.addOne, this);
  },

  addOne: function (initiative) {
    var view = new App.Views.Initiative({model: initiative, el: this.el });
    view.render();
  }

});
