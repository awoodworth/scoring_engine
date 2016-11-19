class MovePaperclipFiles < ActiveRecord::Migration
  @@public_dir = Rails.root.join('public')
  @@system_dir = Rails.root.join('public', 'system')
  @@storage_dir = Rails.root.join('storage')
  @@storage_system_dir = Rails.root.join('storage', 'system')

  def up
    # move public/system to storage/system
    if @@public_dir.children.include?(@@system_dir) and @@system_dir.children.any?
      FileUtils.mkdir(@@storage_dir) unless Rails.root.children.include?(@@storage_dir)
      FileUtils.mv(@@system_dir, @@storage_dir)
    end
  end

  def down
    # move storage/system to public/system
    if Rails.root.children.include?(@@storage_dir) and @@storage_dir.children.include?(@@storage_system_dir) and @@storage_system_dir.children.any?
      FileUtils.mv(@@storage_system_dir, @@public_dir)
      FileUtils.rm_r(@@storage_dir)
    end
  end
end
