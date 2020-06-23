class TranscriptsController < ApplicationController
  before_action :set_transcript, only: [:show]

  def index
    @transcripts = Transcript.all
  end

  def show
  end

  def new
    @transcript = Transcript.new
  end

  def create
    @transcript = Transcript.new(transcript_params)
    if @transcript.save
      redirect_to transcripts_path
    else
      render :new
    end
  end

  private

  def transcript_params
    params.require(:transcript).permit(:title, :speakers, :soundfile)
  end

  def set_transcript
    @transcript = Transcript.find(params[:id])
  end
end
