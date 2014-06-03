App.Views.PeopleTypeahead = Backbone.View.extend({

  template: JST['people/typeahead'],

  events: {
  },

  initialize: function (o) {
    this.board_id = o.board_id;
    this.initTypeaheadSources();
  },

  compile: function (templ) {
    var compiled = _.template(templ);
    compiled.render = function(ctx) {
       return this(ctx);
    }
    return compiled;
  },

  addPeopleTypeahead: function ($input, onSelected) {
    if ($input.length) {
         
      $input.typeahead({
        hint: true,
        minLength: 1
      },
      {
        name: 'people',
        displayKey: 'name',
        // `ttAdapter` wraps the suggestion engine in an adapter that
        // is compatible with the typeahead jQuery plugin
        source: this.sources.people.ttAdapter(),
        templates: {
          empty: [
            '<div class="empty-message">',
            'No users found.',
            '</div>'
          ].join('\n'),
          suggestion: this.compile('<div class="media"><img class="avatar pull-left media-object" src="<%= image %>" /><div class="media-body"><p><%= name %></p></div></div>')
        }
      });
      $input.on('typeahead:selected', function (e, o, name) {
        onSelected(e, o, name);
        $input.typeahead('close');
      });

    }
  },

  addYammerTypeahead: function ($input, onSelected) {
    if ($input.length) {
         
      $input.typeahead({
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
          suggestion: this.compile('<div class="media"><img class="avatar pull-left media-object" src="<%= photo %>" /><div class="media-body"><p><%= full_name %><br /><%= job_title %></p></div></div>')
        }
      });
      $input.on('typeahead:selected', function (e, o, name) {
        onSelected(e, o, name);
        $input.typeahead('close');
      });
    }
  },

  initTypeaheadSources: function () {
    this.sources = {};
    this.sources.users = this.yammerUsersSource();
    // kicks off the loading/processing of `local` and `prefetch`
    this.sources.users.initialize();

    this.sources.people = this.peopleSource();
    this.sources.people.initialize();
  },

  yammerUsersSource: function () {
    return new Bloodhound({
      datumTokenizer: function (d) {
        return Bloodhound.tokenizers.whitespace(d.full_name);
      },
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      limit: 10,
      remote: {
        url: 'https://www.yammer.com/api/v1/autocomplete/ranked?models=user:10&prefix=%QUERY',
        ajax: {
          crossDomain: true,
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ' + ACCESS_TOKEN
          }
        },
        filter: function (parsedResponse) {
          return parsedResponse.user;
        }
      }
    });
  },

  peopleSource: function () {
    return new Bloodhound({
      datumTokenizer: function (d) {
        return Bloodhound.tokenizers.whitespace(d.name);
      },
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      limit: 10,
      prefetch: {
        url: '/boards/' + this.board_id + '/people.json',
        filter: function (parsedResponse) {
          return parsedResponse;
        }
      }
    });
  }

});
