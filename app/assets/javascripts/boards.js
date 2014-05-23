jQuery(function ($) {
  var $form = $('#add-project-member-modal form');
  $form.on('submit', function (e) {
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: $form.attr('action'),
      data: $form.serialize(),
      success: function(o) {
        console.log("success! ", o);
        $ul = nearestCell($(e.target));
        console.log("ul? ", $ul);
        closeNearestPopover($form);
        $ul.append('<li><span class="person-tag" style="background-color:#f6b26b">'+ o.person.name + '</span></li>');
      },
      dataType: 'json'
    });
    return false;
  });


  $('.add-person').on('click', function (e) {
    var $target = $(e.target),
      projectId = $target.data('project-id'),
      roleId = $target.data('role-id');

    // set Project ID and Role ID
    $form.find('input#project_member_project_id').val(projectId);
    $form.find('input#project_member_role_id').val(roleId);

    // init and show popover
    $target.popover({
      html: true,
      placement: 'bottom',
      trigger: 'manual',
      title: function () {
        $title = 'Add a Project Member <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
        return $title;
      },
      content: function () {
        $content = $('#add-project-member-modal form');
        return $content;
      }
    });
    $target.popover('show');

    // hide popover when clicking on "x"
    $('.popover-title .close').on('click', function (e) {
      closeNearestPopover($(e.target));
    });

  // setup typeahead
  var $typeahead = $('#bigboard-autocomplete .typeahead');
  if ($typeahead.length) {
       
    $typeahead.typeahead({
      hint: true,
      minLength: 1
    },
    {
      name: 'people',
      displayKey: 'name',
      // `ttAdapter` wraps the suggestion engine in an adapter that
      // is compatible with the typeahead jQuery plugin
      source: BB.sources.people.ttAdapter(),
      templates: {
        empty: [
          '<div class="empty-message">',
          'No users found.',
          '</div>'
        ].join('\n'),
        suggestion: _.compile('<div class="media"><img class="avatar pull-left media-object" src="<%= image %>" /><div class="media-body"><p><%= name %></p></div></div>')
      }
    });
    $typeahead.on('typeahead:selected', function (e, o, name) {
      if (name == "people") {
        $('#project_member_person_id').val(o.id);
        $('#project_member_person_id').closest('form').submit();
        $typeahead.typeahead('close');
      }
    });
  }
  });

  function closeNearestPopover($target) {
    $target.closest('.popover').siblings('.add-person').popover('hide');
  }

  function nearestCell($target) {
    return $target.closest('td').find('ul');
  }

});
