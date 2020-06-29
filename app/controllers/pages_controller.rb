class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def transcript
    @file = Transcript.find(params[:transcript_id])
    @operation = GoogleTranscriptLongJob.perform_now(@file.soundfile, @file.speakers)
    @file.update(result: @operation)
    @results = @operation.response.results
    @alternatives = @results.last.alternatives
    @alt = @file.result
  end
end
