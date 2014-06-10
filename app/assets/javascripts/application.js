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
//= require underscore
//= require typeahead.js/dist/typeahead.bundle
//= require bootstrap/dist/js/bootstrap.min
//= require backbone
//= require app
//= require_tree ../templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./routers
//= require_tree .

$(document).ready(function(){

  $actions = $('[data-method=delete]');
  if ($actions.length) {
    $actions.on('click', function (e) {
      if (confirm("Are you sure you want to delete?")) { 
        e.preventDefault();
        
        var $target = $(e.target),
          id = $target.data('id'),
          url = $target.attr('href');

        $.ajax({
          type: "DELETE",
          url: url,
          headers: {
           'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          },
          success: function(o) {
            $target.parent().fadeOut();
          },
          dataType: 'json'
        });
      }
    });
  }

});
