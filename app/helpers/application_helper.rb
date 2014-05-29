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
        "<span class=\"person-tag team-#{person.team.id}\" data-project-member-id=\"#{id}\" data-toggle=\"popover\" data-content=\"<img src='#{person.image}' class='avatar' /> #{person.name} | #{person.team.name}\">#{person.name}</span>".html_safe
      end
    end
  end

end
