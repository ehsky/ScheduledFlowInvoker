/**
 * @description       :
 * @author            : erlend.hansen@stretch.no | https://trailblazer.me/id/ehansen7
 * @group             : Test
 * @last modified on  : 02-14-2023
 * @last modified by  : erlend.hansen@stretch.no | https://trailblazer.me/id/ehansen7
 **/
@isTest
public class ScheduledFlowInvokerTest {
  @isTest
  static void testScheduledFlowInvoker() {
    DateTime dt = Datetime.now().addHours(1);
    String cronExp = getCronExpression(dt);

    Test.startTest();

    // Schedule the test job
    String jobId = System.schedule(
      'FlowInvokerTest',
      cronExp,
      new ScheduledFlowInvoker('TestFlow')
    );

    // Get the information from the CronTrigger API object
    CronTrigger ct = [
      SELECT Id, CronExpression, TimesTriggered, NextFireTime
      FROM CronTrigger
      WHERE id = :jobId
    ];
    // Verify the expressions are the same
    System.assertEquals(cronExp, ct.CronExpression);
    // Verify the job has not run
    System.assertEquals(0, ct.TimesTriggered);
    // Verify the next time the job will run
    System.assertEquals(
      dt.format('yyyy-MM-dd HH:mm:ss'),
      String.valueOf(ct.NextFireTime)
    );

    Test.stopTest();
  }

  private static String getCronExpression(DateTime dt) {
    String cronExp = '' + dt.second() + ' ';
    cronExp += dt.minute() + ' ';
    cronExp += dt.hour() + ' ';
    cronExp += dt.day() + ' ';
    cronExp += dt.month() + ' ? ';
    cronExp += dt.year();
    return cronExp;
  }
}
