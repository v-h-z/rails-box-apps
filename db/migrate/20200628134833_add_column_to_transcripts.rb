class AddColumnToTranscripts < ActiveRecord::Migration[6.0]
  def change
    add_column :transcripts, :result, :text
  end
end
