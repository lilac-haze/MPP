require File.expand_path('builders/satellite_builder.rb')

def build_satellite
  engineer = SatelliteBuilder.new
  engineer.set_antennas(4)
  engineer.set_power_system(2)
  engineer.set_housings(2)
  engineer.set_transponders(5)
  engineer.add_gps
  engineer.add_monitoring
  engineer.get_satellite
end

puts "Creating new own satellite!!"
puts "#{build_satellite.inspect}"
puts "\n"
puts "Creating new LEO satellite.."
puts "#{SatelliteBuilder.new.LEO_satellite.inspect}"
puts "\n"
puts "Creating new MEO satellite.."
puts "#{SatelliteBuilder.new.MEO_satellite.inspect}"
puts "\n"
puts "Creating new GEO satellite.."
puts "#{SatelliteBuilder.new.GEO_satellite.inspect}"

