public class WeatherInfoController {
    
    private static final Double hPaTommHg = 0.75;

    @AuraEnabled
    public static Weather getWeatherInfo(String cityName) {
        Weather weather;
        weather = createWeateher(getWeather(getGeo(createUrl(cityName))));
        return weather;
    }

    @AuraEnabled
    public static String getUserCity(String recordId){

        List<Account> accountList = [
                SELECT Id,
                    Owner.City
                FROM Account 
                WHERE Id = :recordId 
        ];
        return accountList[0].Owner.City;
    }

    @AuraEnabled
    public static Account getAccount(String recordId){
        Account account = [
                SELECT Id,
                    Name
                FROM Account 
                WHERE Id = :recordId 
        ];
        return account;
    }

    public static String createUrl(String cityName) {
        OpenWeatherSettings__c openWeatherCustomSetting = OpenWeatherSettings__c.getValues('First');
        GeoLocation_Endpoint__c geoUrlFirstPart= GeoLocation_Endpoint__c.getValues('FirstPart');
        GeoLocation_Endpoint__c geoUrlSecondPart= GeoLocation_Endpoint__c.getValues('SecondPart');
        return geoUrlFirstPart.url__c + cityName + geoUrlSecondPart.url__c + openWeatherCustomSetting.Key__c;
    }

    public static String createUrlWeather(Geo geo) {
        OpenWeatherSettings__c openWeatherCustomSetting = OpenWeatherSettings__c.getValues('First');
        return openWeatherCustomSetting.url__c + geo.latitude + openWeatherCustomSetting.url_second__c + geo.longitude + openWeatherCustomSetting.url_third__c + openWeatherCustomSetting.Key__c + openWeatherCustomSetting.url_fourth__c;
    }

    public static Geo getGeo(String url) {
        Geo geo = new Geo();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            List<GeoForCity> listGeoForCity = (List<GeoForCity>) JSON.deserialize(response.getBody(), List<GeoForCity>.class);
            geo.latitude = String.valueOf(listGeoForCity[0].lat);
            geo.longitude = String.valueOf(listGeoForCity[0].lon);
        }
        return geo;
    }

    public static WeatherForCity getWeather(Geo geo) {
        WeatherForCity weaterForCity;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(createUrlWeather(geo));
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            weaterForCity = (WeatherForCity) JSON.deserialize(response.getBody(), WeatherForCity.class);
        }
        return weaterForCity;
    }

    public static Weather createWeateher(WeatherForCity weatherForCity) {
        Weather weather = new Weather();
        weather.condition = weatherForCity.weather[0].main;
        weather.temperature = weatherForCity.main.temp;
        weather.pressure = weatherForCity.main.pressure * hPaTommHg;
        weather.humidity = weatherForCity.main.humidity;
        weather.windSpeed = weatherForCity.wind.speed;
        weather.windDirection = weatherForCity.wind.deg;
        return weather;
    }

    public class Weather {
        @AuraEnabled
        public String condition {get; set;}
        @AuraEnabled
        public Double temperature{get; set;}
        @AuraEnabled
        public Double pressure {get; set;}
        @AuraEnabled
        public Double humidity {get; set;}
        @AuraEnabled
        public Double windSpeed {get; set;}
        @AuraEnabled
        public Double windDirection {get; set;}
    }

    public class Geo {
        public String latitude;
        public String longitude;
    }
}