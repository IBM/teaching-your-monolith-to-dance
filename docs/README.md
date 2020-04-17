# Teaching Your Monolith to Dance

Application modernization is a journey of moving existing applications to a more modern cloud-native infrastructure.

There are several approaches to application modernization and provided are key reference implementations to help you on your modernization jourey.

### Operational Modernization

* Repackage the application to deploy within a container but maintaining a monolith application without changes to the application or runtime. This solution uses Appsody Operator to deploy and manage the containarized application. 

### Runtime Modernization

* Update the application runtime to Open Liberty, a suitable cloud-native framework, and deploy on Red Hat OpenShift. Modernize some aspects of the application by taking advantage of [MicroProfile](https://microprofile.io/) specifications, such as Health, Metrics, JWT, Config and OpenAPI. This solution uses Open Liberty Operator to deploy and manage the modernized application.

### Application Management

* Monitor the applications easily using various dashboards available as part of Cloud Pak for Applications. Identify potential problems using logging dashboards. Get insights into the performance of your applications using metrics dashboards. Perform Day-2 operations, such as gathering traces and dumps, to debug potential issues easily using Open Liberty Operator. Use Application Navigator to monitor and manage all your applications running on cloud and on-prem.


**Let's get started.** Head over to the [Operational Modernization lab](operational-modernization/README.md).