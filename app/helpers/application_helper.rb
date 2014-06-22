module ApplicationHelper

  def person_tag project_member
    unless project_member.nil?
      if project_member.class == Person
        person = project_member
        id = '';
        url = board_person_url(project_member.board, project_member)
      else
        person = project_member.person;
        id = project_member.id;
        url = edit_project_project_member_path project_member.project, project_member
      end
      if !person.nil?
        color = person.team.color
        location = "<sup>#{person.location}</sup>" unless person.location == 'SF'
        "<a href=\"#{url}\" class=\"person-tag team-#{person.team.id}\" data-project-member-id=\"#{id}\" data-toggle=\"popover\">#{person.name} #{location}</a>".html_safe
      end
    end
  end

  def short_date date
    date.strftime("%d %b %y") unless date.nil?
  end

  def num_weeks start_date, end_date
    end_date = end_date.nil? ? Date.today : end_date
    start_date.nil? ? 0 : ((end_date - start_date).to_f / 7.0).round(1)
  end

  def project_length project
    num_weeks project.start_date, project.end_date
  end

  def nearing_deadline deadline
    num_weeks(deadline, nil) > -1
  end

end
