/********************************************************************************
 * クラス名 ： ContentVersionHandler
 * 概　　要 ： 記事からファイルがアップロードされる時、公開リンクを生成する
 * 作 成 日 ： 2018/06/20 KIM 
 * 更 新 日 ： 2018/03/04 KIM
 * 更新履歴
   ・OC_KELKの案件からファイルアップロード時自動選択リスト選択済み機能追加
 ********************************************************************************/
public class ContentVersionHandler {
    
    // AfterInsert
    public class ContentVersionHandlerAfterInsert implements COM_Triggers.HandlerInterface {
        public void handle() {
            System.debug('*** ContentVersionHandlerAfterInsert handle START ***');
            doAfterInsertExecute( (List<ContentVersion>) Trigger.new );
            System.debug('*** ContentVersionHandlerAfterInsert handle END ***');
        }
    }
    
    /**
     *  アップロードファイルに紐付くレコードが記事の場合、
     *  公開リンクを生成する
     *
     *  @param  List<ContentVersion> conts
     *  @return なし
     *
     */
    private static void doAfterInsertExecute( List<ContentVersion> conts ) {
        System.debug('*** ContentVersion: ' + conts.size());
        list<ContentDistribution> dists = new list<ContentDistribution>();
        String banner = '';
        List<Opportunity> updateOppList = new List<Opportunity>();
        List<Opportunity> oppList = null;
        for(ContentVersion cont : conts){ 
            //20180809 kim mod classicでコンテンツ配信した場合親のオブジェクトIDがnullになるため修正
            if(cont.FirstPublishLocationId == null)continue;
            if ( isKijiParameterId( cont.FirstPublishLocationId ) ) {
                ContentDistribution cd = new ContentDistribution();                
                cd.ContentVersionId = cont.id;
                cd.PreferencesAllowOriginalDownload = true;
                cd.PreferencesAllowPDFDownload = true;
                cd.PreferencesAllowViewInBrowser = true;
                cd.PreferencesNotifyOnVisit = false;
                //20180821 kim mod 記事のプレビューにアップロードファイルが表示されるように改修 start
                banner = cont.Title;
                if(banner.indexOf('Banner') != -1){
                    cd.name = cont.FirstPublishLocationId+cont.Title;
                }else if(banner.indexOf('Thumbnail') != -1){
                    cd.name = cont.FirstPublishLocationId+cont.Title;
                }else{
                    cd.name = cont.Title;
                    cd.RelatedRecordId = cont.FirstPublishLocationId;
                }
                //20180821 kim mod end
                dists.add(cd); 
            }
            System.debug('*** ContentVersionHandlerAfterInsert handle START OC_KELK***');
            //20181220 kim add 案件でレコードタイプOC_KELKのレコードにファイルがアップロードされた場合の処理            
           /* if ( isOppParameterId( cont.FirstPublishLocationId ) ) {
                oppList = new  List<Opportunity>();
                oppList = [SELECT Id,RecordTypeId,OcContent__c,KelkContent__c
                           FROM Opportunity WHERE Id =:cont.FirstPublishLocationId];
                
                if(oppList.size() > 0 && oppList[0].RecordTypeId == System.Label.AP45_CONST_0001){
                    String ocContent = setPickList(cont.Title,oppList[0].OcContent__c,1);
                    String kelkContent = setPickList(cont.Title,oppList[0].kelkContent__c,2);
                    if(ocContent != oppList[0].OcContent__c || kelkContent != oppList[0].kelkContent__c){
                        oppList[0].OcContent__c = ocContent;
                        oppList[0].kelkContent__c = kelkContent;
                        updateOppList.add(oppList[0]);
                    }
                }
            }*/          
        }          
        if(updateOppList.size() > 0){
            update updateOppList;
        }
        if(dists.size() > 0){
            insert dists ;
        }
    }

    /**
     *  複数選択リストにアップロード対象ファイル名が存在しない場合追加。
     *
     *  @param  String ファイル名
     *  @param  String 複数選択リスト値
     *  @param  Integer 判定フラグ
     *  @return String  複数選択リスト値
     *
     */
    private static String setPickList(String title,String picklist,Integer num){
        List<String> fileNameList = null;
        if(num == 1){
           // fileNameList = System.Label.AP45_CONST_0002.split(',');
        }else if(num == 2) {
           // fileNameList = System.Label.AP45_CONST_0003.split(',');
        }
       
        for(String sName : fileNameList){
            if(title.normalizeSpace().containsIgnoreCase(sName)){
                if(String.isEmpty(picklist)){
                    picklist = sName;
                    break;
                }
                else if(!picklist.normalizeSpace().containsIgnoreCase(sName)){
                    picklist += ';'+sName;
                    break;
                }
            }
        }
        return picklist;
    } 

    /**
     *  受け取った ID が記事のIdかどうかを判定します
     *
     *  @param  Id recordId
     *  @return true/false  引数のIDが記事のものであればTrue
     *
     */
    private static Boolean isKijiParameterId( Id recordId ) {
        
        //return String.valueOf( recordId ).startsWith( ASI_M_Kiji__c.sObjectType.getDescribe().getKeyPrefix() );
        return true;
    }
    
    /**
     *  受け取った ID が案件のIdかどうかを判定します
     *
     *  @param  Id recordId
     *  @return true/false  引数のIDが案件のものであればTrue
     *
     */
    private static Boolean isOppParameterId( Id recordId ) {
        
        return String.valueOf( recordId ).startsWith( Opportunity.sObjectType.getDescribe().getKeyPrefix() );
    }

}