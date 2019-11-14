public class AnimalLocator {

    public static String getAnimalNameById(integer id){
        String animalName;
        Object animals; 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
         if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('>>>>>'+response.getBody());
            animals = result.get('animal');
            System.debug(animals);
        }
        if (animals != NULL  ) {
            Map<String, Object> result1 = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(animals));
            animalName =(String) result1.get('name');
        }
        return animalName; 
    }
}