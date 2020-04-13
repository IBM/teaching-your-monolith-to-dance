# Application Management

## Introduction

In the previous labs, you learned to containerize and deploy modernized applications to OpenShift. In this section, you'll learn about managing your running applications efficiently using various tools available to you as part of IBM Cloud Pak for Applications.

## IBM Application Navigator

IBM Application Navigator provides a single dashboard to manage your applications running on cloud as well as on-prem, so you don't leave legacy applications behind. At a glance, you can see all the resources (Deployment, Service, Route, etc) that are part of an application and monitor their state. 

1. From the left-panel, select `Networking` --> `Routes`.
1. From the `Project` drop down menu, select `kappnav`. 
1. Click on the Route URL (listed under the `Location` column).
1. Click on `Log in with OpenShift`. Click on `Allow selected permissions`.
1. Notice the list of applications you deployed. Click on them to see the resources that are part of the applications. 

As you modernize your applications, some workload would still be running on traditional environments. Application Navigator, included as part of Cloud Pak for Applications, supports adding WebSphere Network Deployment (ND) environments. So they can be managed from the same dashboard. Importing an existing WebSphere Application Server ND cell creates a custom resource to represent the cell. Application Navigator automatically discovers enterprise applications that are deployed on the cell and creates custom resources to represent those applications. Application Navigator periodically polls the cell to keep the state of the resources synchronized with the cell. 

Application Navigator also provides links to other dashboards that you already use and are familiar with. You can also define your own custom resources using the extension mechanism provided by Application Navigator. 

## Summary

Congratulations! You've completed the workshop! Great job! Virtual high five!

Check out the [next steps](../resources.md) to continue your journey to cloud!