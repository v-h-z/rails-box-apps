class Transcript < ApplicationRecord
  has_one_attached :soundfile
  validates :title, :speakers, :soundfile, presence: true
end
