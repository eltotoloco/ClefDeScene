class RenameAverageTimeColumAnnonce < ActiveRecord::Migration[5.0]
  def change
  	rename_column :annonces, :average_time_on_stage_in_minutes, :avg_time

  end
end
