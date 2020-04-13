# Access the web terminal

The web terminal runs in your Openshift cluster.

It gives you command line access to many tools you will use in the workshop. 

To access the web terminal:

- From the OpenShift web console, navigate to Networking -> Routes.  Select Project `lab` and click on the URL of route `tools` under "Location".  

  ![Route URL](https://github.com/IBM/openshift-workshop-was/blob/master/setup/images/tools_route.jpg?raw=true)

- Click on `Log in with OpenShift`

- Click on `Allow selected permissions`

  - Note: The authorization permission page above may not display again in the subsequent access.  
The information will already be in the browser cookie cache.

- The web terminal is displayed:

  ![Web Terminal](https://github.com/IBM/openshift-workshop-was/blob/master/setup/images/terminal.jpg?raw=true)

- Enter `ls` to verify that the web terminal lists the files and folders in the directory.