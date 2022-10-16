module Configur
  def LEO_satellite
    self.set_antennas(4)
    self.set_power_system(1)
    self.set_housings(1)
    self.set_transponders(2)
    self.add_gps
    self.get_satellite
  end

  def MEO_satellite
    self.set_antennas(3)
    self.set_power_system(2)
    self.set_housings(1)
    self.set_transponders(1)
    self.add_monitoring
    self.add_observation
    self.get_satellite
  end

  def GEO_satellite
    self.set_antennas(6)
    self.set_power_system(3)
    self.set_housings(1)
    self.set_transponders(3)
    self.add_weatherForecast
    self.add_telecommunication
    self.get_satellite
  end
end

