public class StringArrayTest {

    public static list<String> generateStringArray(integer Length){
        List<String> result = new List<String>();
        for(integer i = 0 ; i < Length; i++){
            result.add('Test ' + i);
        }
        system.debug('result'+result);
        return result;
    }
    
}