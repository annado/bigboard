module ApplicationHelper

  def person_tag project_member
    unless project_member.nil?
      if project_member.class == Person
        person = project_member
        id = '';
      else
        person = project_member.person;
        id = project_member.id;
      end
      if !person.nil?
        color = person.team.color
        url = edit_project_member_path project_member
        "<a href=\"#{url}\" class=\"person-tag team-#{person.team.id}\" data-project-member-id=\"#{id}\" data-toggle=\"popover\">#{person.name}</a>".html_safe
      end
    end
  end

end
