unless Rails.env.eql?("production")
  ActiveRecordQueryTrace.enabled = true
end
