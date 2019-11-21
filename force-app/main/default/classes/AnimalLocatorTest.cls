@isTest
private class AnimalLocatorTest {
    @isTest static void testGetCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String response = AnimalLocator.getAnimalNameById(1);
        system.debug('Test Response1--->'+response);
        String expectedValue = 'trailhead';
        System.assertEquals(expectedValue,response);
    }
}