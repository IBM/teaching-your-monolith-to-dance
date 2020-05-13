# Teaching Your Monolith to Dance

Application modernization is a journey of moving existing applications to a more modern cloud-native infrastructure.

There are several approaches to application modernization and provided are key reference implementations to help you on your modernization journey.

### Operational Modernization

- Repackage the application to deploy within a container but maintaining a monolith application without changes to the application or runtime. This solution uses Appsody Operator, supported by IBM Cloud Pak for Applications, to deploy and manage the containerized application on Red Hat OpenShift.

### Runtime Modernization

- Update the application runtime to Open Liberty, a suitable cloud-native framework. Modernize some aspects of the application by taking advantage of MicroProfile specifications, such as Health, Metrics, JWT, Config and OpenAPI. This solution uses Open Liberty Operator, also supported by IBM Cloud Pak for Applications, to deploy and manage the modernized application on Red Hat OpenShift.

### Application Management

- Monitor the applications easily using various dashboards available as part of IBM Cloud Pak for Applications. Identify potential problems using logging dashboards. Get insights into the performance of your applications using metrics dashboards. Perform Day-2 operations, such as gathering traces and dumps, to debug potential issues easily using Open Liberty Operator. Use Application Navigator to monitor and manage all your applications running on cloud and on-prem.

### Hands-on Workshop

#### Setup

Please follow the [setup instructions](common/setup.md) to access the Red Hat OpenShift cluster on IBM Cloud required for the workshop. The cluster is already configured with the tools you need to be able to complete the labs.

#### Pre-requisites

Basic knowledge about containers and Kubernetes is recommended. Completing the following hands-on labs will help you to easily navigate this workshop:
- [Introduction to Containerization](https://github.com/IBM/openshift-workshop-was/tree/master/labs/Openshift/HelloContainer)
- [Introduction to Container Orchestration using OpenShift](https://github.com/IBM/openshift-workshop-was/tree/master/labs/Openshift/IntroOpenshift)

#### Labs

The labs should be completed in the order they are listed below. A link is provided at the end of each lab to the next lab.

- Lab 1: [Operational Modernization](operational-modernization/README.md)
- Lab 2: [Runtime Modernization](runtime-modernization/README.md)
- Lab 3: [Application Management](application-management/README.md)

### Resources

After completing the labs, checkout the next steps and additional resources available [here](resources.md) to continue your journey to cloud!

