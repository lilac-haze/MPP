require File.expand_path('models/satellite.rb')
require File.expand_path('builders/satellites/configur.rb')

class SatelliteBuilder < Satellite
  include Configur

  def initialize
    @satellite = Satellite.new
  end

  def set_antennas(antennas)
    @satellite.antennas = antennas
  end

  def set_power_system(power_system)
    @satellite.power_system = power_system
  end

  def set_housings(housings)
    @satellite.housings = housings
  end

  def set_transponders(transponders)
    @satellite.transponders = transponders
  end

  def add_telecommunication
    @satellite.has_telecommunication = true
  end

  def add_monitoring
    @satellite.has_monitoring = true
  end

  def add_pool
    @satellite.has_pool = true
  end

  def add_gps
    @satellite.has_gps = true
  end

  def add_weatherForecast
    @satellite.has_weatherForecast = true
  end

  def add_observation
    @satellite.has_observation = true
  end

  def get_satellite
    @satellite
  end
end

