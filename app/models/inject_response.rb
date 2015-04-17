class InjectResponse < ActiveRecord::Base

  belongs_to :inject
  belongs_to :user

  has_attached_file :submission#, path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :submission, content_type: [ 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/pdf' ]
  validates :submission, attachment_presence: true
  validates_with AttachmentSizeValidator, attributes: :submission, less_than: 20.megabytes

  def on_time?
    self.created_at <= self.inject.due_at
  end
end
