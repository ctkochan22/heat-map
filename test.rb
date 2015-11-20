require_relative "config/environment"


class Test
include HTTParty
  def self.agency()
    url = "http://services.my511.org/Transit2.0/GetAgencies.aspx?token=d7addd58-ca1e-4395-96f6-55440646c3ae"

    p response = HTTParty.get(url).parsed_response
    p response["RTT"]["AgencyList"]["Agency"][6]
  end

  def self.routes()
    url = "http://services.my511.org/Transit2.0/GetRoutesForAgencies.aspx?token=d7addd58-ca1e-4395-96f6-55440646c3ae&agencyNames=SF-MUNI"

    response = HTTParty.get(url).parsed_response
    p response["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"][0]
  end

  def self.stops()
    url = "http://services.my511.org/Transit2.0/GetStopsForRoute.aspx?token=d7addd58-ca1e-4395-96f6-55440646c3ae&routeIDF=SF-MUNI~1~Inbound"
    response = HTTParty.get(url).parsed_response
    final = response["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]
    # ap final
    return final
  end

  def self.all_departures()
    url ="http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=d7addd58-ca1e-4395-96f6-55440646c3ae&stopcode=13825"
    response = HTTParty.get(url).parsed_response
    ap response["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]
  end

  def self.departures(stopCode)
    url ="http://services.my511.org/Transit2.0/GetNextDeparturesByStopCode.aspx?token=d7addd58-ca1e-4395-96f6-55440646c3ae&stopcode=#{stopCode}"
    response = HTTParty.get(url).parsed_response
    array_test = response["RTT"]["AgencyList"]["Agency"]["RouteList"]["Route"]

    # return array_test

    if array_test.kind_of?(Array)
      array_test.each do |stop|
        return stop["Name"]
      end
    else
      # return array_test["RouteDirectionList"]
      return "----"
    end



    # [0]["RouteDirectionList"]["RouteDirection"]["StopList"]["Stop"]
  end

  def self.geolocation(route)
    base_url = "http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=sf-muni&r="
    url = base_url + route.to_s
    response = HTTParty.get(url).parsed_response
    ap response["body"]["route"]["stop"]
  end

end

# Test.agency()
# Test.routes()
# Test.stops()
# Test.all_departures()
# Test.geolocation("22")
# array = Test.departures("13546")
# array.each do |test|
#   ap test
# end

# stops = Test.stops()
# stops.each do |stop|
#   code = stop["StopCode"]
#   ap Test.departures(code)
# end

ap Test.departures("14028")[0]["Name"]
ap Test.departures("14028")[1]["Name"]

ap Test.departures("14028")
# array.each do |test|
#   ap test["Name"]
# end