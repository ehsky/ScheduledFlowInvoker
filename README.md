# Scheduled Flow Invoker

***If you can use batch flows instead then this is highly recommended***

## Background

This repository was created to bypass the permission issue one would get if we used Batch flows. \
Batch flows is run by "Automated Process" user and we are unable to add additional permissions for this user.

## Deploy

You can use the quick installer here to deploy the code directly to your org. \
[![Deploy to salesforce](https://githubsfdeploy.herokuapp.com/resources/img/deploy.png)](https://githubsfdeploy.herokuapp.com?owner=ehsky&repo=ScheduledFlowInvoker&ref=main)

## How to use

- From setup icon click on **Developer Console**.
- In the developer console, click on **Anonymous Apex**.
- Paste in the following code `System.schedule('ScheduleFlow every hour', '0 0 * * * ?', new ScheduledFlowInvoker('FlowDeveloperName'));`
  - The first parameter *ScheduleFlow every hour* is your personal reference of what type of scheduled job this is.
  - The secund parameter *0 0 * * * ?* is a telling the scheduled job how often you want it to run.
  - The third parameter *new ScheduledFlowInvoker('FlowDeveloperName')* is this class repo. You need to change the ***FlowDeveloperName*** to the API name of the auto launched flow you want to run.

You can use this website https://www.freeformatter.com/cron-expression-generator-quartz.html to generate your *cron expression*