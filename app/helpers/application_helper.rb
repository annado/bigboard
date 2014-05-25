module ApplicationHelper

  def person_tag person
    if !person.nil?
      color = person.team.color
      "<span class=\"person-tag\" style=\"background-color:#{color}\" data-toggle=\"popover\" data-content=\"<img src='#{person.image}' class='avatar' /> #{person.name} | #{person.team.name}\">#{person.name}</span>".html_safe
    end
  end

end
