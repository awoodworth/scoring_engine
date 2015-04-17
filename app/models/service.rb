class Service < ActiveRecord::Base
  self.table_name = "nagios_objects"

  default_scope {where("objecttype_id = 2 AND is_active = 1")}

  def self.for_team(team)
    fuzzy_team = "#{team}%"
    self.where("name1 LIKE ?", fuzzy_team)
  end

  def status
    conn = ActiveRecord::Base.connection
    result = conn.execute("SELECT current_state FROM nagios_hoststatus WHERE host_object_id = #{self.object_id};")
    ans = 0
    result.each do |stat|
      ans = stat[0]
    end
    ans.eql?(1)
  end
end
