window.App = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  collections: {},
  initialize: function() {
    this.csrfToken = $("meta[name='csrf-token']").attr('content');

    Backbone.sync = (function(original) {
      return function(method, model, options) {
        options.beforeSend = function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', App.csrfToken);
        };
        original(method, model, options);
      };
    })(Backbone.sync);
  }
};

$(document).ready(function(){
  App.initialize();
});
