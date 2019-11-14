@isTest
global class BillingCalloutServiceMock implements WebServiceMock{
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            // start - specify the response you want to send
            BillingServiceProxy.billProjectResponse_element billProjectResponse = 
                new BillingServiceProxy.billProjectResponse_element ();
            billProjectResponse.status = 'OK';
            response.put('response_x', billProjectResponse); 
        }
}