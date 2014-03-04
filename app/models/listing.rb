class Listing < ActiveRecord::Base

  GEOFACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column(:coords, GEOFACTORY.projection_factory)

  def coords=(coords)
    write_attribute(:coords, GEOFACTORY.point(coords[:lat], coords[:lng]).projection)
  end

  def coords
    GEOFACTORY.unproject(read_attribute(:coords))
  end

  def self.in_rect(w, s, e, n)
    sw = GEOFACTORY.point(w, s).projection
    ne = GEOFACTORY.point(e, n).projection

    box = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne)
    where(["coords @ ST_MakeEnvelope(?, ?, ?, ?)", sw.x, sw.y, ne.x, ne.y])
  end

  # def self.estonia
  #   in_rect(57.426285, 21.494751, 59.699281, 28.795166)
  # end

  # def self.tallinn
  #   in_rect(59.374086, 24.583626, 59.511627, 25.047112)
  # end

end
