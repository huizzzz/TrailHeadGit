public class ChatterSample {
     
    /**
     * HHSとHHTとのTM連絡票更新情報をチャッター投稿
     * @param sObject ic 更新対象のsObject
     * @param sObject oldHhs 比較元のsObject
     * @param sObject newHhs 比較対象のsObject
     * add kim 2018/11/14
     */
    public void IcChatterInsert(Account ic,Account oldHhs, Account newHhs,Decimal HhsHhtFlag) {

        ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
        ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
        ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
        ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
        
        messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
        
        textSegmentInput.text = 'HHT連絡票の変更が発生しました。';
        textSegmentInput.text += '\n';
        messageBodyInput.messageSegments.add(textSegmentInput);
                            
        // Mention a group.
        mentionSegmentInput.id = 'Sample_ID';
        messageBodyInput.messageSegments.add(mentionSegmentInput);
        feedItemInput.body = messageBodyInput;
        feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
                            
        // Use a record ID for the subject ID.
        feedItemInput.subjectId = ic.Id;
        //chatter投稿関連機能はテストクラス実行でエラー発生のため回避       
        ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(null, feedItemInput);
    }
}