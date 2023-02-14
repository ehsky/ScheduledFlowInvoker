/**
 * @description       : Reusable class to invoke a flow from a scheduled job.
 *                      This the flow will then be run as the user who created the scheduled job.
 *                      This is an alternative to using the a Batch flow in salesforce as this is 
 *                      run as Automated Process user.
 * @author            : erlend.hansen@stretch.no | https://trailblazer.me/id/ehansen7
 * @group             : Toolbox
 * @last modified on  : 02-14-2023
 * @last modified by  : erlend.hansen@stretch.no | https://trailblazer.me/id/ehansen7
 * @example
 * System.schedule('ScheduleFlow every hour', '0 0 * * * ?', new ScheduledFlowInvoker('FlowDeveloperName'));
**/
public class ScheduledFlowInvoker implements Schedulable {
    
    private String flowApiName;
    
    public ScheduledFlowInvoker(String flowApiName) {
        this.flowApiName = flowApiName;
    }
    
    public void execute(SchedulableContext sc) {
        // Launch the flow
        Map<String, Object> inputs = new Map<String, Object>();
        
        if(!Test.isRunningTest()){
            Flow.Interview interview = Flow.Interview.createInterview(flowApiName, inputs);
            interview.start();
        } else {
            System.debug('Test is running, skipping flow invocation as flow name does not exist.');
        }
    }
    
}
