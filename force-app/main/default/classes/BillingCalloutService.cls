public class BillingCalloutService {
    //Implement business and callout logic methods here
    public static void callBillingService(List<Project__c> proNewList,Map<id,Project__c> proOldMap){
        
        List<Project__C> projectsToSync = new List<Project__C>();
        For(Project__c proNew : proNewList){
            Project__c proOld = proOldMap.get(proNew.id);
            if(checkProStatus(proNew,proOld)){
               projectsToSync.add(proNew); 
            }
        }
        makeCallout(JSON.serialize(projectsToSync));
    }
    
    @future( callout = true )
    public static void makeCallout( String serializedProjects ) {
        List<Project__C> recordsToBeProcessed = ( List<Project__C> )JSON.deserialize( serializedProjects, List<Project__C>.class );
        
        // Holds project Ids with callout responses
        Map<String, String> mapCalloutResponses = new Map<String, String>();
        
        // Retrieving the token
        ServiceCredentials__c billingServiceToken = ServiceCredentials__c.getvalues('BillingServiceCredential');
        
        // List of Soap Requests to Process
        List<BillingServiceProxy.project> soapRequests = new List<BillingServiceProxy.project>();
        
        List<Project__C> projectsToUpdate = new List<Project__C>();
        
        for ( Project__c proj: recordsToBeProcessed ) {
            BillingServiceProxy.project project = new BillingServiceProxy.project();
            project.projectid = proj.ProjectRef__c;
            project.billAmount = proj.Billable_Amount__c;
            project.username = billingServiceToken.Username__c;
            project.password = billingServiceToken.Password__c;
            soapRequests.add( project );
        }
        
        for ( BillingServiceProxy.project soapPayloads : soapRequests ) {
            BillingServiceProxy.InvoicesPortSoap11 invoiceCall = new BillingServiceProxy.InvoicesPortSoap11();
            mapCalloutResponses.put( soapPayloads.projectid, invoiceCall.billProject( soapPayloads ) );
        }
        
        // Iterating over the result to confirm if the project can be updated
        for ( String projectReference: mapCalloutResponses.keySet() ) {
            if ( mapCalloutResponses.get( projectReference ) != null &&  mapCalloutResponses.get( projectReference ).equalsIgnoreCase('OK') ) {
                Project__c projectToUpdate = new Project__c( ProjectRef__c = projectReference );
                projectToUpdate.Status__c = 'Billed';
                projectsToUpdate.add( projectToUpdate );	
            }
        }
        
        if ( projectsToUpdate.size() > 0 ) {
            upsert projectsToUpdate ProjectRef__c;
        }
    }
    private static Boolean checkProStatus(Project__C proNew,Project__C proOld){
        if(proNew.Status__c == 'Billable' && proNew.Status__c != proOld.Status__c){
            return true;
        }
        return false;
    }
    
    public class ProjectWrapper {
        public String ProjectRef;
        public Decimal Amount;
        
        public ProjectWrapper( String ProjectRef, Decimal Amount) {
            this.ProjectRef = ProjectRef;
            this.Amount = Amount;
        }
    }
}