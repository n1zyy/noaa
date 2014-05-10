module NOAA
  class HttpService #:nodoc:
    def initialize(http = Net::HTTP)
      @HTTP = http
    end

    def get_current_conditions(station_id)
      LibXML::XML::Document.string(get(URI.parse("http://www.weather.gov/xml/current_obs/#{station_id}.xml")))
    end

    def get_forecast(num_days, lat, lng)
      LibXML::XML::Document.string(get("http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=#{lat}&lon=#{lng}&format=24+hourly&numDays=#{num_days}"))
    end

    def get_station_list
      LibXML::XML::Document.string(get("http://www.weather.gov/xml/current_obs/index.xml"))
    end

    def get(url)
      open(url.to_s).read
    end
  end
end
