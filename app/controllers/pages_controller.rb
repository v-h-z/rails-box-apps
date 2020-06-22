class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def transcript
    @operation = GoogleTranscriptLongJob.perform_now
    @results = @operation.response.results
    @alternatives = @results.last.alternatives
  end
end
