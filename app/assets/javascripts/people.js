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
      datumTokenizer: function (d) {
        return Bloodhound.tokenizers.whitespace(d.full_name);
      },
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      limit: 10,
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
     
    $typeahead.typeahead({
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
        suggestion: _.compile('<p><img class="avatar" src="<%= mugshot_url %>" height="40" /> <%= full_name %></p>')
      }
    });
    $typeahead.on('typeahead:selected', function (e, o, name) {
      if (name == "users") {
        $('#person_uid').val(o.id);
        $('#person_image').val(o.mugshot_url);
      }
      $typeahead.typeahead('close');
    });
  }
});

