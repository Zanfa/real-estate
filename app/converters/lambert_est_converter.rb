class LambertEstConverter

  @@ef = 500000
  @@nf = 6375000
  @@lat1 = (59 + 1.0/3.0) * Math::PI / 180 
  @@lat2 = 58 * Math::PI / 180 
  @@latf = 57.517553930555555555555555555556 * Math::PI / 180 
  @@lonf = 24.0 * Math::PI / 180 
  @@a = 6378137
  @@ee = 0.081819191042815792
  @@m1 = Math.cos(@@lat1) / (Math.sqrt(1 - @@ee * @@ee * Math.sin(@@lat1) ** 2))
  @@m2 = Math.cos(@@lat2) / (Math.sqrt(1 - @@ee * @@ee * Math.sin(@@lat2) ** 2))
  @@t1 = Math.tan(Math::PI / 4.0 - @@lat1 / 2.0) / (( (1.0 - @@ee * Math.sin(@@lat1)) / (1.0 + @@ee * Math.sin(@@lat1))) ** (@@ee / 2.0))
  @@t2 = Math.tan(Math::PI / 4.0 - @@lat2 / 2.0) / (( (1.0 - @@ee * Math.sin(@@lat2)) / (1.0 + @@ee * Math.sin(@@lat2))) ** (@@ee / 2.0))
  @@tf = Math.tan(Math::PI / 4.0 - @@latf / 2.0) / (( (1.0 - @@ee * Math.sin(@@latf)) / (1.0 + @@ee * Math.sin(@@latf))) ** (@@ee / 2.0))
  @@n  = (Math.log(@@m1) - Math.log(@@m2)) / (Math.log(@@t1) - Math.log(@@t2))
  @@f  = @@m1 / (@@n * @@t1 ** @@n)
  @@rf  = @@a * @@f * @@tf **  @@n
  @@epsilon = 1e-11


  def self.to_lat_lng(px, py)
    r = Math.sqrt((px - @@ef) ** 2 + (@@rf - py + @@nf) ** 2 ) * 1 # Math.signum(@@n)
    t = (r / (@@a * @@f)) ** (1.0 / @@n)
    theta = Math.atan((px - @@ef) / (@@rf - py + @@nf))
    y = (theta / @@n + @@lonf)
    x = (iterate_angle(@@ee, t))
    {lat: x * 180 / Math::PI, lng: y * 180 / Math::PI}
  end

  private
  def self.iterate_angle(e, t)
    a1 = 0.0
    a2 = 3.1415926535897931
    a = 1.5707963267948966
    b = 1.5707963267948966 - (2.0 * Math.atan(t * ((1.0 - (e * Math.sin(a))) / (1.0 + (e * Math.sin(a)))) ** (e / 2.0)))
    while (a-b).abs > @@epsilon do
      a = a1 + ((a2 - a1) / 2.0)
      b = 1.5707963267948966 - (2.0 * Math.atan(t * ((1.0 - (e * Math.sin(a))) / (1.0 + (e * Math.sin(a)))) ** (e / 2.0)))
      return 0.0 if a1 == a2
      if b > a
        a1 = a
      else
        a2 = a
      end
    end

    b
  end

end
