public class testSideBarController {
    
    @AuraEnabled
    /*
     * @Description リンクIDより該当リストビュー取得
     * @Param ListViewName リストビュー名前
     * @Return ListView ID
     * */
    public static id getListViewID(){
        return [select id,SobjectType from listview limit 1].id;
    }
    
    @AuraEnabled
    public static map<String,String> getListViewMap(){
        map<String,String> testMap = new map<String,String>();
        ListView lv = [select id,SobjectType from listview limit 1];
        testMap.put('Key',lv.id);
        testMap.put('Value',lv.SobjectType);
        return testMap;
    }

    @AuraEnabled
    public static map<String,String> getListViewMultiMap(){
        map<String,String> testMap = new map<String,String>();
        List<ListView> lvLst = [select id,SobjectType from listview limit 3];
        for(ListView lv : lvLst){
            testMap.put(lv.id,lv.SobjectType);
            
        }
        system.debug('testMap'+testMap);
        return testMap;
    }
    
     @AuraEnabled
    public static List<ListView> getListViewLST(){
        return [select id,SobjectType,name from listview limit 3];
    }
}