module ApplicationHelper

  def person_tag person
    if !person.nil?
      color = person.team.color
      "<span class=\"person-tag\" style=\"background-color:#{color}\">#{person.name}</span>".html_safe
    end
  end

end
