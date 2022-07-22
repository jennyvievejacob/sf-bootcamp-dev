public class AsynchronousExercise2 implements Schedulable{
    
	public void execute(SchedulableContext sc) {
        AsynchronousExercise1 batch = new AsynchronousExercise1();	
        Database.executeBatch(batch);
    }
    
}

/*AsynchronousExercise2 ex2 = new AsynchronousExercise2();
    String cron = '0 0 0 * * ?';
    system.schedule('Test job 12MN', cron, ex2);*/