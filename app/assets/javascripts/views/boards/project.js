BigBoard.Views.Project = Backbone.View.extend({

  events: {
    "click .close": "clearPopovers",
    "click .add-person": "showAddProjectMember"
  },

  initialize: function (o) {
    this.addAll();
    this.model.project_members.on("add", this.addProjectMember, this);
  },

  addProjectMember: function (project_member) {
    var $list = this.$el.find('[data-role-id=' + project_member.attributes.role_id + '] ul');
    var view = new BigBoard.Views.ProjectMember({ model : project_member });
    $list.append(view.render().$el);
  },

  addAll: function () {
    this.model.project_members.each(this.addOne, this);
  },

  addOne: function (project_member) {
    var el = this.$el.find('[data-project-member-id=' + project_member.id + ']');
    var view = new BigBoard.Views.ProjectMember({model : project_member, el : el});
    view.render();
  },

  showAddProjectMember: function (e) {
    var $target = $(e.target),
      role_id = $target.data('role-id'),
      project_id = this.id;

    this.clearPopovers();

    var popover = new BigBoard.Views.ProjectMembers.New({ role_id: role_id, project_id: project_id, model: this.model });
    this.popover = popover;

    var clearPopovers = _.bind(this.clearPopovers, this);

    $target.popover({
      html: true,
      placement: 'bottom',
      trigger: 'manual',
      title: function () {
        $title = 'Add a Project Member <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
        return $title;
      },
      content: function () {
        $content = popover.render().$el;
        $content.on('close', clearPopovers);
        return $content;
      }
    });
    $target.popover('show');
  },

  clearPopovers: function () {
    $('.add-person').popover('destroy');
    this.popover = null;
  }

});
