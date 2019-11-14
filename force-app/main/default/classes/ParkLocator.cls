public class ParkLocator {
    public static List<String> country(String Country) {
        ParkService.ParksImplPort  parks = 
            new ParkService.ParksImplPort();
        return parks.byCountry(Country);
    }
}