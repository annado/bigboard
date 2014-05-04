// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(function ($) {
  var $typeahead = $('#autocomplete .typeahead');

  _.compile = function(templ) {
      var compiled = this.template(templ);
      compiled.render = function(ctx) {
         return this(ctx);
      }
      return compiled;
   }

  if ($typeahead.length) {
    var users = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: {
        // url: 'https://api.yammer.com/api/v1/autocomplete/ranked?models=users:10&prefix=%QUERY',
        url: 'https://api.yammer.com/api/v1/users/in_group/976603.json',
        ajax: {
          crossDomain: true,
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ' + ACCESS_TOKEN
          }
        },
        filter: function (parsedResponse) {
          return parsedResponse.users;
        }
      },
      prefetch: {
        // url: 'https://api.yammer.com/api/v1/autocomplete/ranked?models=users:10&prefix=%QUERY',
        url: 'https://api.yammer.com/api/v1/users/in_group/976603.json',
        ajax: {
          crossDomain: true,
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ' + ACCESS_TOKEN
          }
        },
        filter: function (parsedResponse) {
          return parsedResponse.users;
        }
      }

    });
     
    // kicks off the loading/processing of `local` and `prefetch`
    users.initialize();
     
    $('#autocomplete .typeahead').typeahead({
      hint: true,
      minLength: 1
    },
    {
      name: 'users',
      displayKey: 'full_name',
      // `ttAdapter` wraps the suggestion engine in an adapter that
      // is compatible with the typeahead jQuery plugin
      source: users.ttAdapter(),
      templates: {
        empty: [
          '<div class="empty-message">',
          'No users found.',
          '</div>'
        ].join('\n'),
        suggestion: _.compile('<p><img src="<%= mugshot_url %>" height="40" /> <%= full_name %></p>')
      }
    });
  }
});

