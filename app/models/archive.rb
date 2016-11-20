class Archive
  require 'zip'

  # This class allows for archiving of paperclip files
  # path: :rails_root/storage/system/archive/:archive_type/:date/:file_name

  ARCHIVE_DIR = Rails.root.join('storage', 'system', 'archive')
  INJECT_DIR = ARCHIVE_DIR + 'inject'

  ARCHIVE_DIRS = [
    INJECT_DIR
  ]


  def self.archive_injects(injects)
    ensure_directories

    # move injects to an array if a single instance
    injects = [injects] if injects.is_a?(Inject)

    # set up archive_dir and file_name
    @archive_dir = INJECT_DIR + Date.today.to_s
    FileUtils.mkdir(@archive_dir) unless INJECT_DIR.children.include?(INJECT_DIR + Date.today.to_s)
    @file_name = "injects_#{Time.now.strftime("%Y%m%d-%H%M%S")}.zip"

    # incase multiple calls to archive_injects are made at the exact same time
    if @archive_dir.children.include?(@archive_dir + @file_name)
      sleep 1
      @file_name = "injects_#{Time.now.strftime("%Y%m%d-%H%M%S")}.zip"
    end

    injects.each do |inject|
      if inject.inject_responses.any?
        Zip::File.open(@archive_dir + @file_name, Zip::File::CREATE) do |zipfile|
          inject.inject_responses.includes(:user).references(:user).each do |inject_response|
            # Example File In Zip: inject_x/inject_x_team-x.pdf
            zipfile.add("inject_#{inject.id}/inject_#{inject.id}_#{inject_response.username}#{File.extname(inject_response.submission.path)}", inject_response.submission.path)
          end
        end
      end
    end
    return @archive_dir + @file_name
  end

  private
  def self.ensure_directories
    FileUtils.mkdir(ARCHIVE_DIR) unless Rails.root.join('storage', 'system').children.include?(ARCHIVE_DIR)
    ARCHIVE_DIRS.each do |dir|
      FileUtils.mkdir(dir) unless ARCHIVE_DIR.children.include?(dir)
    end
  end
end
