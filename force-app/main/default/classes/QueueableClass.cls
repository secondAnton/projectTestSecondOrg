public class QueueableClass implements Queueable {
    
    private String text;

    public QueueableClass(String text) {
        this.text = text;
    }

    public void execute(QueueableContext context) {
        system.debug('Queueable ' + text);
        //FutureClass.futureMethod1('AAAA');
        //BatchClass batchClass = new BatchClass('Batch From Future');
        //Id batchId = Database.executeBatch(batchClass);

        SchedulableClass1 schedulableClass = new SchedulableClass1('JJJJJ');
        String sch = '0 40 9 27 9 ? 2023';
        String jobID = System.schedule('SchedulableClass1', sch, schedulableClass);
    }
}