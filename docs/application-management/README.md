# Application Management

## Introduction

In the previous labs, you learned to containerize and deploy modernized applications to OpenShift. In this section, you'll learn about managing your running applications efficiently using various tools available to you as part of IBM Cloud Pak for Applications.

## IBM Application Navigator

IBM Application Navigator provides a single dashboard to manage your applications running on cloud as well as on-prem, so you don't leave legacy applications behind. At a glance, you can see all the resources (Deployment, Service, Route, etc) that are part of an application and monitor their state. 

1. In OpenShift console, from the left-panel, select **Networking** > **Routes**.

1. From the _Project_ drop-down list, select `kappnav`. 
1. Click on the route URL (listed under the _Location_ column).
1. Click on `Log in with OpenShift`. Click on `Allow selected permissions`.
1. Notice the list of applications you deployed. Click on them to see the resources that are part of the applications. 

As you modernize your applications, some workload would still be running on traditional environments. Application Navigator, included as part of IBM Cloud Pak for Applications, supports adding WebSphere Network Deployment (ND) environments. So they can be managed from the same dashboard. Importing an existing WebSphere Application Server ND cell creates a custom resource to represent the cell. Application Navigator automatically discovers enterprise applications that are deployed on the cell and creates custom resources to represent those applications. Application Navigator periodically polls the cell to keep the state of the resources synchronized with the cell. 

Application Navigator also provides links to other dashboards that you already use and are familiar with. You can also define your own custom resources using the extension mechanism provided by Application Navigator. 

## Logging

1. In OpenShift console, from the left-panel, select **Networking** > **Routes**.

1. From the _Project_ drop-down list, select `openshift-logging`. 
1. Click on the route URL (listed under the _Location_ column).
1. Click on `Log in with OpenShift`. Click on `Allow selected permissions`.
1. From the left-panel, click on `Management`.
1. Click on `Index Patterns`. Click on `project.*`. This index contains only a set of default fields and does not include all of the fields from the deployed application’s JSON log object. Therefore, the index needs to be refreshed to have all the fields from the application’s log object available to Kibana. Click on the refresh icon and then click on `Refresh fields`.
1. Let's import dashboards for Liberty and WAS. From the left-panel, click on `Management`. Click on `Saved Objects` tab and then click on `Import`.
1. Select `ibm-open-liberty-kibana5-problems-dashboard.json` file. When prompted, click the `Yes, overwrite all` option.
1. 


## Monitoring



## Day-2 Operations

You may need to gather traces and/or JVM dumps for analyzing some problems. Open Liberty Operator makes it easy to gather these on a server running inside a container.

A storage must be configured so the generated artifacts can persist, even after the Pod is deleted. This storage can be shared by all instances of the Open Liberty applications.
RedHat OpenShift on IBM Cloud utilizes the storage capabilities provided by IBM Cloud. Let's create a request for storage.

### Request storage

1. In OpenShift console, from the left-panel, select **Storage** > **Persistent Volume Claims**.

1. From the _Project_ drop-down list, select `apps`. 
1. Click on `Create Persistent Volume Claim` button.
1. Ensure that `Storage Class` is `ibmc-block-gold`. If not, make the selection from the list.
1. Enter `liberty` for `Persistent Volume Claim Name` field.
1. Request 1 GiB by entering `1` in the text box for `Size`.
1. Click on `Create`.
1. Created Persistent Volume Claim will be displayed. The `Status` field would display `Pending`. Wait for it to change to `Bound`. It may take 1-2 minutes.
1. Once bound, you'll see the created volume displayed under `Persistent Volume` field.

### Enable serviceability

1. From the left-panel, click on **Operators** > **Installed Operators**.
1. Ensure that `apps` is selected from the _Project_ drop-down list. 
1. You should see `Open Liberty Operator` on the list. Click on `Open Liberty Application` (displayed under `Provided APIs` column).
1. Click on the application named `cos` which you previously deployed.
1. Click on the `YAML` tab.
1. Specify the storage request (Persistent Volume Claim) you made earlier to Open Liberty Operator and it will find the actual volume from the claim name. To avoid indentation issues, replace the line with `spec:` with the following YAML content:

    ```yaml 
    spec:
      serviceability:
        volumeClaimName: liberty
    ```
1. Click on `Save`.
1. From the left-panel, click on **Workloads** > **Pods**. Wait till the pod's _Readiness_ column change to _Ready_.
1. Click on the pod and copy its name. This is needed for requesting JVM dump and trace.

### Request JVM dump

1. From the left-panel, click on **Operators** > **Installed Operators**.

1. From the `Open Liberty Operator` row, click on `Open Liberty Dump` (displayed under `Provided APIs` column).
1. Click on `Create OpenLibertyDump` button.
1. Replace `Specify_Pod_Name_Here` with the pod name you copied earlier.
1. The `include` field specifies the type of JVM dumps to request. Heap and thread dumps are specified by default. Leave it as is.
1. Click on `Create`.
1. Click on `example-dump` from the list.


## Summary

Congratulations! You've completed the workshop! Great job! Virtual high five!

Check out the [next steps](../resources.md) to continue your journey to cloud!