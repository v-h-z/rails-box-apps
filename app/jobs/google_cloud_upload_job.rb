class GoogleCloudUploadJob < ApplicationJob
  queue_as :default

  def perform(filepath)
    # Do something later
    upload(filepath)
  end

  def upload(filepath)
    bucket_name = "sound_for_text_to_speech"
    local_file_path = filepath
    storage_file_path = "/app"

    require "google/cloud/storage"

    storage = Google::Cloud::Storage.new
    bucket  = storage.bucket bucket_name

    file = bucket.create_file local_file_path, storage_file_path

    puts "Uploaded #{file.name}"

    return file
  end
end
