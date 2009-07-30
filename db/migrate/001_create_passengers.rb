class CreatePassengers < ActiveRecord::Migration
  def self.up
    create_table :passengers do |t|
      t.string :name
      t.string :job_id
      t.string :contact_number
      t.string :suburb_origin
      t.string :street
      t.string :street_number
      t.string :building
      t.string :suburb_destination
      t.integer :passenger_number
      t.string :taxi_type
      t.date :date
      t.time :time_required

      t.timestamps
    end
  end

  def self.down
    drop_table :passengers
  end
end
