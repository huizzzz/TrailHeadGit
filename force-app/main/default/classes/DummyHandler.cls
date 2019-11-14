public class DummyHandler {
    
    //多数件で一括対応する際のトリガー更新例
     public void yosanSet(List<Contact> newObjectsList){
        
        List<String> sqitemsIdList = new List<String>();
        
        for(Contact newsqitem : newObjectsList) {
            sqitemsIdList.add(newsqitem.AccountId);
        }
        
        List<Contact> sqitemsList = [SELECT Id, AccountId
                                          FROM Contact
                                          WHERE AccountId IN: sqitemsIdList];
        
        Set<String> specialQuotationIdSet = new Set<String>();
        for(Contact sqitems : sqitemsList) {
            if(specialQuotationIdSet.isEmpty()) {
                specialQuotationIdSet.add(sqitems.AccountId);
            } else {
                if(!specialQuotationIdSet.contains(sqitems.AccountId)) {
                    specialQuotationIdSet.add(sqitems.AccountId);   
                }
            }
        }
        
        //Add by Comture ZH 20190529 見積調書明細数積み上げ
        Map<String, Integer> sqitemsNumberMap = new Map<String, Integer>();
        for(String specialQuotationId : specialQuotationIdSet) {
            Integer count = 0;
            for(Contact sqitems : sqitemsList) {
                if(sqitems.AccountId == specialQuotationId) {
                    count++;
                }
            }
            sqitemsNumberMap.put(specialQuotationId, count);
        }
        
        List<Account> updateSpecialQuotationList = [SELECT Id,NumberOfTest__c //Add by Comture ZH 20190529
                                                                  FROM Account
                                                                  WHERE Id IN: specialQuotationIdSet];
        
        for(Account sq : updateSpecialQuotationList) {
            sq.NumberOfTest__c = sqitemsNumberMap.get(sq.Id);
        }
        
        if(updateSpecialQuotationList.size() > 0) {
            update updateSpecialQuotationList;
        }
        
    }
    
    //単一件に対してトリガーで項目更新例
     /**
     * BeforeUpdateイベントの場合の処理
     * @param List<SUP_Request__c> newList
     * @param Map<Id, SUP_Request__c> newMap
     * @param List<SUP_Request__c> oldList
     * @param Map<Id, SUP_Request__c> oldMap
     */
      public void onBeforeUpdate(List<Account> newList, Map<Id, Account> newMap, List<Account> oldList, Map<Id, Account> oldMap ){

        Account newAcc = newList[0];
        Account oldAcc = oldList[0];

        //依頼の回答数を取得する。
        AggregateResult ag = [select count(Id) cnt from Contact where AccountId = :newAcc.id];
        //依頼の回答数を設定する。
        newAcc.NumberOfTest__c = Integer.valueOf(ag.get('cnt'));
    }
    
}