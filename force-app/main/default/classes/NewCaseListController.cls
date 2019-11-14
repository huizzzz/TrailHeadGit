public class NewCaseListController {
    public Boolean test{get;set;}
    public List<Case> NewCases{get;set;}
    public NewCaseListController(){
        test = true;
        NewCases= [select id,CaseNumber from case where status = 'new'];
        if(NewCases.size() > 0){
            //test = true;
        }
        
    }
    
    
}