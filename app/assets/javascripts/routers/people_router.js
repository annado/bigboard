App.Routers.People = Backbone.Router.extend({
  
  initialize: function (options) {
    App.typeahead = new App.Views.PeopleTypeahead({
      board_id: options.board.id
    });
  },

  routes: {
    ".*" : "show"
  },

  show: function () {
    var $typeahead = $('#autocomplete .typeahead');
    if ($typeahead.length) {
      App.typeahead.addYammerTypeahead($typeahead, $.proxy(function (e, o, name) {
        if (name == "users") {
          $('#person_uid').val(o.id);
          $('#person_image').val(o.photo);
        }
        $typeahead.typeahead('close');
      }, this));
    }
  }

});
