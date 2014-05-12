// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(function ($) {
  var $typeahead = $('#autocomplete .typeahead');
  if ($typeahead.length) {
       
    $typeahead.typeahead({
      hint: true,
      minLength: 1
    },
    {
      name: 'users',
      displayKey: 'full_name',
      // `ttAdapter` wraps the suggestion engine in an adapter that
      // is compatible with the typeahead jQuery plugin
      source: BB.sources.users.ttAdapter(),
      templates: {
        empty: [
          '<div class="empty-message">',
          'No users found.',
          '</div>'
        ].join('\n'),
        suggestion: _.compile('<div class="media"><img class="avatar pull-left media-object" src="<%= photo %>" /><div class="media-body"><p><%= full_name %><br /><%= job_title %></p></div></div>')
      }
    });
    $typeahead.on('typeahead:selected', function (e, o, name) {
      if (name == "users") {
        $('#person_uid').val(o.id);
        $('#person_image').val(o.photo);
      }
      $typeahead.typeahead('close');
    });
  }
});

