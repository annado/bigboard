// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require underscore/underscore-min
//= require typeahead.js/dist/typeahead.bundle
//= require bootstrap/dist/js/bootstrap.min
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree .

if (typeof BB == "undefined") {
  var BB = { sources: {} };
};

BB.sources.users = new Bloodhound({
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
 
// kicks off the loading/processing of `local` and `prefetch`
BB.sources.users.initialize();


BB.sources.people = new Bloodhound({
  datumTokenizer: function (d) {
    return Bloodhound.tokenizers.whitespace(d.name);
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

_.compile = function(templ) {
    var compiled = this.template(templ);
    compiled.render = function(ctx) {
       return this(ctx);
    }
    return compiled;
 }

$(document).ready(function(){

  $('[data-behaviour~=datepicker]').datepicker({
    format: "yyyy-mm-dd",
    todayBtn: "linked",
    autoclose: true,
    todayHighlight: true
  });
});
