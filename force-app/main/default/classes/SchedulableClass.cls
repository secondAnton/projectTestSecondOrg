public class SchedulableClass implements Schedulable {
    
    private String textVar;

    public SchedulableClass(String text) {
        textVar = text;
    }

    public void execute(SchedulableContext ctx) {
        system.debug('From Schedulable  ' + textVar);
        //FutureClass.futureMethod1('Schedulable');
    }
}