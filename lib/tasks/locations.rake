namespace :locations do
  desc "Migrate from static locations to a Location model"
  task migrate: :environment do
    old_locations = ['UK', 'SF', 'YN']
    Board.all.each do |b|
      new_locations = {}
      old_locations.each do |loc|
        new_location = b.locations.build(:name => loc)
        if new_location.save
          new_locations[loc] = new_location.id
          print "New location created for #{loc}\n"
        else
          new_locations[loc] = b.locations.find_by(:name => loc).id
          print "Existing location found for #{loc} id=#{new_locations[loc]}\n"
        end
      end

      b.people.each do |p|
        if p.location.nil?
          p.location_id = new_locations[p.location_old]
          if p.save
            print "Updated location for Person #{p.id} to #{p.location_id}\n"
          else
            print "Failed to set location for Person #{p.id}\n"
          end
        else
          print "Location already set for Person #{p.id} (#{p.location_id}, was #{p.location_old})\n"
        end
      end

      b.initiatives.each do |i|
        i.projects.each do |p|
          if p.location.nil?
            p.location_id = new_locations[p.location_old]
            if p.save
              print "Updated location for Person #{p.id} to #{p.location_id}\n"
            else
              print "Failed to set location for Person #{p.id}\n"
            end
          else
            print "Location already set for Project #{p.id} (#{p.location_id}, was #{p.location_old})\n"
          end
        end
      end
    end
  end

end
