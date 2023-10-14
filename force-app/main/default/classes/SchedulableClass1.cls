public class SchedulableClass1 implements Schedulable {
    
    private String textVar;

    public SchedulableClass1(String text) {
        textVar = text;
    }

    public void execute(SchedulableContext ctx) {
        system.debug('From Schedulable1  ' + textVar);
        //FutureClass.futureMethod1('Schedulable');
        //QueueableClass queueableClass = new QueueableClass('DDDDD');
        //System.enqueueJob(queueableClass);

        SchedulableClass schedulableClass = new SchedulableClass('JJJJJ');
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
        String sch = '0 25 10 27 9 ? 2023';
        String jobID = System.schedule('SchedulableClassInner', sch, schedulableClass);
    }
}