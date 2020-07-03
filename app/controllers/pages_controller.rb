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
    raise
  end

  def random
    # sleep 1
    # render :message
    @number = (0..100).to_a.sample
    render json: @number
  end

  def message
    # @number = (0..100).to_a.sample
    # render json: @number
  end
end
