class Guide < ActiveRecord::Base
  uuid_it

  has_attached_file :file, path: ":rails_root/storage/system/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :file, content_type: [ 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/pdf' ]
  validates :file, attachment_presence: true
  validates_with AttachmentSizeValidator, attributes: :file, less_than: 20.megabytes
end
