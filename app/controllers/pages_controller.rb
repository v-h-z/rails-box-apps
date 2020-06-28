class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def transcript
    @file = Transcript.find(params[:transcript_id])
    @operation = GoogleTranscriptLongJob.perform_now(@file.soundfile, @file.speakers)
    @file.record.update(result: @operation)
    raise
    @results = @operation.response.results
    @alternatives = @results.last.alternatives
  end
end
