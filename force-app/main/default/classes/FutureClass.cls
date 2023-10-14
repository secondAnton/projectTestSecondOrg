public class FutureClass {
    
    public String textVar;

    @future
    public static void futureMethod1(String text) {
        system.debug('FROM Future 1  with queueable' + text);
        //QueueableClass queueableClass = new QueueableClass('DDDDD');
        //System.enqueueJob(queueableClass);
        //SchedulableClass1 schedulableClass = new SchedulableClass1('JJJJJ');
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
        //String sch = '0 25 0 26 9 ? 2023';
        //String jobID = System.schedule('SchedulableClass1', sch, schedulableClass);

        BatchClass batchClass = new BatchClass('Batch From Future');
        Id batchId = Database.executeBatch(batchClass);
    }

    @future
    public static void futureMethod2(String text) {
        system.debug('FROM Future 2  ' + text);
        
    }

}