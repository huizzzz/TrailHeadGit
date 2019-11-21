public class COM_Triggers {

    /**
    各イベント
    */
    public enum Evt {
        afterdelete, afterinsert, afterundelete,
        afterupdate, beforedelete, beforeinsert, beforeupdate
    }

    /**
    各イベントのハンドラー処理
    */
    public interface HandlerInterface {
        void handle();
    }

    /**
    key:enumのアクション,value:各アクションクラス
    */
    Map < String, List < HandlerInterface >> eventHandlerMapping = new Map < String, List < HandlerInterface >> ();

    /**
    xxx.triggerファイルにてハンドラークラスに対しバインドを行う
    */
    public COM_Triggers bind(Evt event, HandlerInterface eh) {
        List < HandlerInterface > handlers = eventHandlerMapping.get(event.name());
        if (handlers == null) {
            handlers = new List < HandlerInterface > ();
            eventHandlerMapping.put(event.name(), handlers);
        }
        handlers.add(eh);
        return this;
    }

    /**
    xxx.triggerにてイベントのバインド後、eventHandlerMappingに格納した各アクションのhandle()を呼び出す
    */
    public void manage() {

        Evt ev = null;
        if (Trigger.isInsert && Trigger.isBefore) {
            ev = Evt.beforeinsert;
        } else if (Trigger.isInsert && Trigger.isAfter) {
            ev = Evt.afterinsert;
        } else if (Trigger.isUpdate && Trigger.isBefore) {
            ev = Evt.beforeupdate;
        } else if (Trigger.isUpdate && Trigger.isAfter) {
            ev = Evt.afterupdate;
        } else if (Trigger.isDelete && Trigger.isBefore) {
            ev = Evt.beforedelete;
        } else if (Trigger.isDelete && Trigger.isAfter) {
            ev = Evt.afterdelete;
        } else if (Trigger.isundelete) {
            ev = Evt.afterundelete;
        }

        List < HandlerInterface > handlers = eventHandlerMapping.get(ev.name());

        if (handlers != null && !handlers.isEmpty()) {
            for (HandlerInterface h: handlers) {
                h.handle();
            }
        }
    }
}