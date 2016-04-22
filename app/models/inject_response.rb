class InjectResponse < ActiveRecord::Base
  attr_accessor :summary, :dashboard

  uuid_it
  belongs_to :inject
  has_one :event, through: :inject
  belongs_to :user

  has_attached_file :submission#, path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename"
  # validates_attachment_content_type :submission, content_type: [ 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/pdf' ]
  validates_attachment_file_name :submission, matches: [ /doc?x\Z/, /pdf\Z/, /txt\Z/, /rtf\Z/ ]
  validates :submission, attachment_presence: true
  validates_with AttachmentSizeValidator, attributes: :submission, less_than: 20.megabytes

  validates_numericality_of :score, allow_nil: true

  scope :for_current_event, ->(event=Event.current_or_most_recent) { joins(:event).where('events.id = ?', event) }
  scope :in_event_order, ->() { joins(:event).order('events.unavailable_at DESC') }

  delegate :username, to: :user

  def on_time?
    self.created_at <= self.inject.due_at
  end
end
