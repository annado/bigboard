jQuery(function ($) {
  var $form = $('.new_project_member').detach();

  $('.row-board').on('submit', '.new_project_member', function (e) {
    console.log('e? ', e);
    var $form = $(e.target);
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: '/projects/' + $form.find('#project_member_project_id').val() + '/project_members',
      data: $form.serialize(),
      success: function(o) {
        console.log("success! ", o);
        // $(e.target).closest('popover').siblings('add-person').popover('destroy');
        $ul = nearestCell($(e.target));
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
      roleId = $target.data('role-id'),
      existingPopovers = $('.add-person');

    $('.add-person').popover('destroy');
    
    // set Project ID and Role ID
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
        $content = $form.clone();
        $content.find('input#project_member_project_id').val(projectId);
        $content.find('input#project_member_role_id').val(roleId);
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
    $target.closest('.popover').siblings('.add-person').popover('destroy');
  }

  function nearestCell($target) {
    return $target.closest('td').find('ul');
  }

  var $tags = $('.person-tag');
  if ($tags.length) {
    $tags.popover({ placement: 'top', trigger: 'hover', html: true });
  }
});
