require "google/cloud/speech"

class GoogleTranscriptLongJob < ApplicationJob
  queue_as :default

  def perform(soundfile, speakers)
    # Do something later
    # connect
    google_example(soundfile, speakers)
  end

  def connect
    project_id = "skilled-outlook-280513"

    require "google/cloud/storage"

    # If you don't specify credentials when constructing the client, the client
    # library will look for credentials in the environment.
    storage = Google::Cloud::Storage.new project: project_id

    # Make an authenticated API request
    storage.buckets.each do |bucket|
      puts bucket.name
    end
  end

  def google_example(soundfile, speakers)
    storage_path = "gs://sound_for_text_to_speech/" + soundfile.key

    speech = Google::Cloud::Speech.speech

    config = { encoding:          :LINEAR16,
               sample_rate_hertz: 44_100,
               language_code:     "fr-FR",
               # "model": "video",
               enable_word_time_offsets: true,
               enable_automatic_punctuation: true,
               "diarization_config": {
                 "enable_speaker_diarization": true,
                 "min_speaker_count": speakers,
                 "max_speaker_count": speakers,
               }
              }
    audio = { uri: storage_path }

    operation = speech.long_running_recognize config: config, audio: audio

    puts "Operation started"

    operation.wait_until_done!

    raise operation.results.message if operation.error?

    return operation

    # @results = @operation.response.results

    # @alternatives = @results.first.alternatives
    # alternatives.each do |alternative|
    #   puts "Transcription: #{alternative.transcript}"
    # end
  end
end
