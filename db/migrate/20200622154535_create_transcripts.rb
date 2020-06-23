class CreateTranscripts < ActiveRecord::Migration[6.0]
  def change
    create_table :transcripts do |t|
      t.string :title
      t.integer :speakers

      t.timestamps
    end
  end
end
