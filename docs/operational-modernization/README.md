# Cloud Pak for Applications: Operational Modernization Solution

## Introduction

**Operational modernization** gives an operations team the opportunity to embrace modern operations best practices without putting change requirements on the development team. Modernizing from WebSphere Network Deployment (ND) to the **traditional WebSphere Application Server Base V9 runtime** in a container allows the application to be moved to the cloud without code changes.

The scaling, routing, clustering, high availability and continuous availability functionality that WebSphere ND previously provided will be handled by containers orchestrator Red Hat OpenShift and allows the operations team to run cloud-native and older applications in the same environment with the same standardized logging, monitoring and security frameworks.

While traditional WebSphere isn't a 'built for the cloud' runtime like Liberty, it can still be run in container and will receive the benefits of the consistency and reliability of containers as well as helping to improve DevOps and speed to market.

**This type of modernization shouldn't require any code changes** and can be driven by the operations team. **This path gets the application in to a container with the least amount of effort but doesn't modernize the application or the runtime.**

As organizations modernize to cloud platforms, new technologies and methodologies will be used for build, deployment and management of applications. While this modernization will be focused on cloud-native (built for the cloud) applications, using the traditional WebSphere container will allow common technologies and methodologies to be used regardless of the runtime.

  The diagram below shows the high level decision flow where IBM Cloud Transformation Advisor is used to analyze existing assets and a decision is made to not make code changes to the application and use the traditional WebSphere container as the target runtime.

  ![decision flow](extras/images/tWASflow.jpg)

This repository holds a solution that is the result of an **operational modernization** for an existing WebSphere Java EE application that was moved from WebSphere ND v8.5.5 to the traditional WebSphere Base v9 container and is deployed by the IBM CloudPak for Applications to RedHat OpenShift.

In this workshop, we'll use **Customer Order Services** application as an example. In order to modernize, the application will go through through **analysis**, **build** and **deploy** phases. Click [here](../common/application.md) and get to know the application, its architecture and components.

## Table of Contents

- [Analysis](#analysis)
- [Build](#build)
- [Deploy](#deploy)
- [Access the Application](#access-the-application)
- [Summary](#summary)

## Analysis

[IBM Cloud Transformation Advisor](https://www.ibm.com/garage/method/practices/learn/ibm-transformation-advisor) was used to analyze the existing Customer Order Services application running in the WebSphere ND environment. The steps taken were:

1. Used the IBM Cloud Transformation Advisor available as part of IBM Cloud Pak for Applications. Transformation Advisor Local (Beta) can also be used. 

2. Downloaded and executed the **Data Collector** against the existing WebSphere ND runtime.

3. Uploaded the results of the data collection to IBM Cloud Transformation Advisor. A screenshot of the analysis is shown below:

    ![tWAS](extras/images/tWAS-analyze/analysis2.jpg)

4. Analyzed the **Detailed Migration Analysis Report**. In summary, no code changes are required to move this application to the traditional WebSphere Base v9 runtime and the decision was to proceed with the operational modernization.

**Homework**: After you complete this workshop, review the step-by-step instructions on how to replicate these steps from the [Next Steps](../resources.md) section. Then try Transformation Advisor with one of your applications.

## Build

In this section, you'll learn how to build a Docker image for Customer Order Services application running on traditional WebSphere Base v9.

Building this image could take around ~10 minutes (since the image is ~2GB and starting/stopping the WAS server as part of the build process takes few minutes). So let's kick that process off and then come back to learn what you did. Hopefully, the image will be built by the time you complete this section.

Follow the instructions [here](../common/web-terminal.md) to login to OpenShift cluster via the web terminal.

Clone the GitHub repo with the lab artifacts. Run the following commands on your web terminal:
```
cd / && mkdir was90 && cd was90
git clone --branch was90 https://github.com/IBM/teaching-your-monolith-to-dance.git
cd teaching-your-monolith-to-dance
```

Run the following command in web terminal to start building the image. While the image is building continue with rest of this section:

```
docker build --tag image-registry.openshift-image-registry.svc:5000/apps-was/cos-was .
```

As per container's best practices, you should always build immutable images. Injecting environment specific values at deployment time is necessary most of the times and is the only exception to this rule. 

You should create a new image which adds a single application and the corresponding configuration. You should avoid configuring the image manually (after it started) via Admin Console or wsadmin (unless it is for debugging purposes) because such changes won't be present if you spawn a new container from the image. 

We started with the `wsadmin` script that is used by existing Customer Order Services running on-prem. Since this is a legacy application, it runs on older frameworks: most notably it uses JPA 2.0 and JAX-RS 1.1. These are not the default in WAS 9 (as they are in WAS8.5.5), but they are supported. To avoid making application code changes at this time, we modified these settings in the scripts.

For example, older JAX-RS specification is configured by adding:
```
AdminTask.modifyJaxrsProvider(Server, '[ -provider 1.1]')
```

Review the contents of the [wsadmin script](https://github.com/IBM/teaching-your-monolith-to-dance/blob/was90/config/cosConfig.py).

We are going to install the application using a properties file, which is an alternative way to install the application, or apply any configuration. The application could also be installed using the `wsadmin` jython script, but we chose to use the properties file to show the two methods configurations can be applied at build time.
Review the contents of the [properties file](https://github.com/IBM/teaching-your-monolith-to-dance/blob/was90/config/app-update.props). The first block specifies Application resource type, followed by the properties, including the location of the ear file:

```
ResourceType=Application
ImplementingResourceType=Application
CreateDeleteCommandProperties=true
ResourceId=Deployment=CustomerOrderServicesApp

Name=CustomerOrderServicesApp
TargetServer=!{serverName}
TargetNode=!{nodeName}
EarFileLocation=/work/apps/CustomerOrderServicesApp.ear
```

Some environment variables are specified towards the end:

```
cellName=DefaultCell01
nodeName=DefaultNode01
serverName=server1
```

Let's review the contents of the [Dockerfile](https://github.com/IBM/teaching-your-monolith-to-dance/blob/was90/Dockerfile):

```dockerfile
FROM ibmcom/websphere-traditional:9.0.5.0-ubi

COPY --chown=1001:0 resources/db2/ /opt/IBM/db2drivers/

COPY --chown=1001:0 config/PASSWORD /tmp/PASSWORD

COPY --chown=1001:0 config/cosConfig.py /work/config/

COPY --chown=1001:0 config/app-update.props  /work/config/

COPY --chown=1001:0 app/CustomerOrderServicesApp-0.1.0-SNAPSHOT.ear /work/apps/CustomerOrderServicesApp.ear

RUN /work/configure.sh
```

- The base image for our application image is `ibmcom/websphere-traditional`, which is the [official image](https://github.com/WASdev/ci.docker.websphere-traditional) for traditional WAS Base in container. The tag `9.0.5.0-ubi` indicates the version of WAS and that this image is based on Red Hat's Universal Base Image (UBI). We recommend using UBI images.

- We need to copy everything that the application needs into the container. So we copy the db2 drivers which are referenced in the wsadmin jython script.

- Specify a password for the wsadmin user at `/tmp/PASSWORD`. This is optional. A password will be automatically generated if one is not provided. This password can be used to login to Admin Console (should be for debugging purposes only).

- We copy `cosConfig.py` jython script and the `app-update.props` file into `/work/config/` folder, so they are run during container creation.

- Then we copy application ear to the `EarFileLocation` referenced in `app-update.props`

- Then we run the `/work/configure.sh` which will start the server and run the scripts and apply the properties file configuration.  

Each instruction in the Dockerfile is a layer and each layer is cached. You should always specify the volatile artifacts towards the end.

--------

This is the command you ran earlier.

```
docker build --tag image-registry.openshift-image-registry.svc:5000/apps-was/cos-was .
```

It instructs docker to build the image following the instructions in the Dockerfile in current directory (indicated by the `"."` at the end).

A specific name to tag the built image with is also specified. The value `image-registry.openshift-image-registry.svc:5000` in the tag is the address of the internal image registry provided by OpenShift. The registry is accessible within the cluster using the `Service`. Format of a Service address is: _name_._namespace_.svc

5000 is the port, which is followed by namespace and name for the image. Later when we push the image to to push the built image to (within the registry).

[comment]: <> (Optional: Show how to access the image registry service using OpenShift console)


Go back to the web terminal to check on the image build.

You should see the following message if image was successfully built. Please wait if it's still building.:

```
Successfully tagged image-registry.openshift-image-registry.svc:5000/apps-was/cos-was
```

Validate that image is in the repository by running command:

```
docker images
```

You should get an output similar to this. Notice that the base image, websphere-traditional, is also listed. It was pulled as the first step of building application image.

```
REPOSITORY                                                             TAG                 IMAGE ID            CREATED             SIZE
image-registry.openshift-image-registry.svc:5000/apps-was/cos-was      latest              9394150a5a15        10 minutes ago      2.05GB
ibmcom/websphere-traditional                                           9.0.5.0-ubi         898f9fd79b36        12 minutes ago      1.86GB
```

You built the image and verified that it's available locally.

Let's push the image into OpenShift's internal image registry. First, login to the image registry by running the following command in web terminal. A session token is obtained using the `oc whoami -t` command and used as the password to login.

```
docker login -u openshift -p $(oc whoami -t) image-registry.openshift-image-registry.svc:5000
```

[comment]: <> (Specify how to create a project in OpenShift - is it needed?)

Now, push the image into OpenShift's internal image registry:

```
docker push image-registry.openshift-image-registry.svc:5000/apps-was/cos-was
```
[comment]: <> (Optional: Show how to see the pushed image using command line)
[comment]: <> (Optional: Show how to see the pushed image under ImageStreams in OS console)


## Deploy

The following steps will deploy the modernized Customer Order Services application in a traditional WebSphere Base container to a RedHat OpenShift cluster.

Customer Order Services application uses DB2 as its database. You can connect to an on-prem database that already exists or migrate the database to cloud. Since migrating the database is not the focus of this particular workshop and to save time, the database needed by the application is already configured in the OpenShift cluster you are using.

**Homework**: Learn about data modernization by checking out [IBM Cloud Pak for Data](https://www.ibm.com/ca-en/products/cloud-pak-for-data): a fully-integrated data and AI platform that modernizes how businesses collect, organize and analyze data and infuse AI throughout their organizations.

### Operator

Operators are a method of packaging, deploying, and managing a Kubernetes application. Conceptually, Operators take human operational knowledge and encode it into software that is more easily shared with consumers. Essentially, Operators are pieces of software that ease the operational complexity of running another piece of software. They act like an extension of the software vendor’s engineering team, watching over a Kubernetes environment (such as OpenShift Container Platform) and using its current state to make decisions in real time.

We'll use [Appsody Operator](https://github.com/appsody/appsody-operator/blob/master/doc/user-guide.md) to deploy the application. Appsody Operator is capable of deploying any application image with consistent, production-grade Quality of service (QoS).

[comment]: <> (Explain what an operator is and what Appsody Operator does specifically)

We'll use the following `AppsodyApplication` custom resource (CR), to deploy the Customer Order Services application:

  ```yaml
  apiVersion: appsody.dev/v1beta1
  kind: AppsodyApplication
  metadata:
    name: cos-was
    namespace: apps-was
  spec:
    applicationImage: image-registry.openshift-image-registry.svc:5000/apps-was/cos-was
    service:
      port: 9080
    readinessProbe:
      httpGet:
        path: /CustomerOrderServicesWeb/index.html
        port: 9080
      periodSeconds: 10
      failureThreshold: 3
    livenessProbe:
      httpGet:
        path: /CustomerOrderServicesWeb/index.html
        port: 9080
      periodSeconds: 30
      failureThreshold: 6
      initialDelaySeconds: 90
    expose: true
    route:
      termination: edge
      insecureEdgeTerminationPolicy: Redirect
  ```

  - The `apiVersion` and the `kind` specifies the custom resource to create. `AppsodyApplication` in this case.
  - The metadata specifies a name for the instance of `AppsodyApplication` custom resource (CR) and the namespace to deploy to.
  - The image you pushed to internal registry is specified for `applicationImage` parameter.
  - The port for service is specified as 9080.
  - Readiness probe specifies when the application, running inside the pod, is ready to accept traffic. Traffic will not be sent to it unless it's in `Ready` state.
  - Liveness probe specifies the ongoing health of the running container. The container will be restarted when liveness probe failures exceed the specified threshold.
  - For probes, we are using the main page `/CustomerOrderServicesWeb/index.html`, which is not the best indication that the app is fully functional. Since the application was not modified, it's the best option. 
  - The settings on probes are:
    - `periodSeconds`: how often (in seconds) to perform the probe
    - `failureThreshold` - When a Pod starts and the probe fails, Kubernetes will try this many times before giving up. Giving up in case of liveness probe means restarting the container - in hope that the problem will be resolved when restarted. In case of readiness probe the Pod will be marked _unready_. Kubernetes will not send traffic to Pod unless it's marked _ready_.
    - `initialDelaySeconds`: Number of seconds after the container has started before probes is initiated. Allows the application to complete initial setups.
  - The `expose` field is a simple toggle to enable Route (proxy) - to expose your application outside the cluster. 
  - The termination policy specified under `route` configures a secured route.

### Deploy application

1. In OpenShift console, from the panel on left-side, click on **Operators** and then **Installed Operators**.
1. From the `Project` drop down menu, select `apps-was`. 
1. You'll see `Appsody Operator` on the list. From the `Provided APIs` column, click on `Appsody Application`.
1. Click on `Create AppsodyApplication` button.
1. Delete the default template. 
1. Copy and paste the above `AppsodyApplication` custom resource (CR).
1. Click on `Create` button.
1. Click on `cos-was` from the list. 
1. Navigate down to `Conditions` section and wait for `Reconciled` type to display `True` in Status column.
1. Click on the `Resources` tab. The resources that the operator created will be listed: Deployment, Service and Route.
1. On the row with `Deployment` as `Kind`, click on `cos` to get to the Deployment.
1. Click on `Pods` tab. 
1. Wait until the `Status` column displays _Running_ and `Readiness` column displays _Ready_. These indicate that the application within the container is running and is ready to handle traffic.

    [comment]: <> (Optional exercise: delete the pod. Another pod should be created, but takes awhile for it to be ready. Shows that traditional WAS is slow, but Liberty as they'll see later is faster)

You containerized and deployed the application to RedHat OpenShift.

## Access the application

1. From the left-panel, select `Networking` and then `Routes`
1. Note that the URL, listed under the `Location` column, is in the format< application_name >-< project_name >.< ocp cluster url >.
1. Click on the Route URL
1. Add `/CustomerOrderServicesWeb` to the end of the URL in the browser to access the application

    ![Dev Running](extras/images/deployed-app.jpg)

1. Log in to the application. Enter `skywalker` for username and `force` for password.

1. Click on the `Account` tab to see user details.

1. From the `Shop` tab, add few items to the cart. Click on an item and then drag and drop the item into the shopping cart.

1. As the items are added, they'll be shown under _Current Shopping Cart_ (on the left side)

## Summary

Congratulations! You've completed the first section of the workshop! 

This application has been modified from the initial WebSphere ND v8.5.5 version to the traditional WebSphere Base v9 container and is deployed by the IBM CloudPak for Applications to RedHat OpenShift.

Let's continue with the workshop. Head over to the [Runtime Modernization lab](../runtime-modernization/README.md).