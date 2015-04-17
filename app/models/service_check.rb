class ServiceCheck < ActiveRecord::Base
  self.table_name = "nagios_servicechecks"

  scope :up, ->() {where(return_code: 0)}
  scope :down, ->() {where("return_code NOT LIKE 0")}

  def up?
    self.return_code == 0
  end

  def down?
    !up?
  end

end
