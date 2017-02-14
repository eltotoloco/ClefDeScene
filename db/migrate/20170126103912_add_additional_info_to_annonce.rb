class AddAdditionalInfoToAnnonce < ActiveRecord::Migration[5.0]
  def change
  	    add_column :annonces, :level, :integer
  	    add_column :annonces, :min_days_for_booking, :integer
  	    add_column :annonces, :price, :integer
  	    add_column :annonces, :average_time_on_stage_in_minutes, :integer
  end
end
