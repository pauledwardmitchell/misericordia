desc "This task loads contracts from old db"

task :update_buildings => :environment do

  buildings_data = File.read('db/data/Building_update.json')
  buildings_data_as_json = JSON.parse(buildings_data)

  buildings_data_as_json.each do |building|

    updated_building = Building.find(building["id"])

    updated_building.update(annual_elec_usage: building["AnnualElecUse"], annual_gas_usage: building["AnnualGasUse"])

    puts "Now: Elec: " + updated_building.annual_elec_usage.to_s + " and Gas: " + updated_building.annual_gas_usage.to_s

  end

end
