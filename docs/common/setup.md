# Workshop Setup

This section contains instructions to access Openshift Clusters for those workshops that use IBM public cloud

## Prerequisite

You will be given a URL specific to your workshop (e.g. `https://<workshop name>.mybluemix.net/`), and a lab key for the cluster assignment through email before the workshop session. 
 
## Browser Requirement

- Please use Firefox or Chrome when possible during the workshop. It's been noted IE or Edge browser may cause an unexpected behavior accessing the URLs for the lab.
- When accessing Open Shift Web Console through IBM Cloud login, you may experience the block pop-up from the browser, please ensure to unblock in order to proceed. 
  - Also note other type of blocks may be caused by your company's firewall rules, please check if any alternative can be used.

## Signing up with a new or existing IBMid

You can sign up for an IBM Cloud account by using your existing IBMid or by creating a new IBMid.
To sign up for IBM Cloud with an IBMid:
- Go to the [IBM Cloud login page](https://cloud.ibm.com), and click **Create an IBM Cloud account**.
- Enter your IBMid email address. If you don't have an existing IBMid, an ID is created based on the email that you enter.
- Complete the remaining fields with your information, and click **Create account**.
- Confirm your account by clicking the link in the confirmation email that's sent to your provided email address.
- **Note**: If your IBMid is not with email pattern (e.g., a shortname), please inform the workshop presenter then a manual cluster assignment will be made accordinly. In the next step ##Cluser Assignment, you will start by logging in [IBM Cloud login page](https://cloud.ibm.com) and continue with the step "- Once logged in, ensure that the account selected is **2044184 - CP4AWorkshops**".

Note: You may optionally deactivate your account after the lab. 
However, we encourage you to keep your account for future labs. 
After deactivation, you will need to contact IBM Support to reactivate it. 
If you insist on deactivation, follow the instructions on the support page for "lite account": https://www.ibm.com/support/pages/how-can-you-cancel-your-ibm-cloud-account.


## Cluster assignment

- Point your browser to the workshop URL which is given through email; or check again with the workshop presenter. 
- Enter the lab key for your workshop and your IBM ID (with email pattern) to get assigned a cluster.

  ![Workshop assignment](images/Initial.jpg)

- After sumitting successfully, the Congratuations page similar to the following is displayed:


  ![Workshop cluster assigned](images/assignment.jpg)


- From the page, note about your assigned cluster name and ignore the bullet 5 which is not used in this workshop.
- Login to the link **IBM Cloud account** with your IBM ID.
- Once logged in, ensure that the account selected is **2044184 - CP4AWorkshops**

  ![CP4Apps Account](images/CP4AppsAccount.jpg)

- Navigate to IBM CLoud > Resource list

  ![Resource list](images/ResourceList.jpg)

- Expand `clusters` and click on your cluster

  ![clusters](images/Clusters.jpg)

- Click `Openshift Web Console` to get access to the console for your cluster.
- Ignore the `IBM Cloud Shell` button for now. It gives you a command line terminal to interact with IBM cloud, and may be used for a future lab.
 
  ![console](images/Console.jpg)

## Access the web terminal

The web terminal runs in your Openshift cluster. It gives you command line access to many tools you will use in the workshop. 

The following steps to access the web terminal are illustrated in the screen recording below:

1. From the OpenShift web console, navigate to **Networking** > **Routes**.  Select Project `lab` from the drop-down list and click on the URL of route `tools` (listed under `Location` column). 

1. Click on `Log in with OpenShift`

1. Click on `Allow selected permissions`

    - Note: The authorization permission page above may not display again in the subsequent access as the information will already be in the browser cookie cache.

1. The web terminal will be displayed. 

1. Enter `ls` to verify that the web terminal lists the files and folders in the directory.

    ![web terminal](images/web-terminal.gif)


## Login to OpenShift CLI

The following steps to login to OpenShift CLI (command-line interface) using web terminal are illustrated in the screen recording below:

1. From the Openshift console, click on the twisty next to your login name and select `Copy Login Command`.

1. In the new window that pops up, click on `Display Token`:

1. To login to your OpenShift cluster, copy the command under `Log in with this token`, then paste it into the web terminal. The command looks like:

    ```
    oc login --token=<TOKEN> --server=<SERVER Address>
    ```

1. After login, the project last accessed is displayed, and it may or may not be the `default` project shown below:

    ```
    Logged into "<SERVER address" as "<USER>" using the token provided.

    You have access to 56 projects, the list has been suppressed. You can list all projects with 'oc projects'
    
    Using project "default".
    ```

1. Leave the web terminal open as it's needed for the labs.

    ![oc login](images/oc-login.gif)


Congratulations! You've completed the lab setup.

## Next

**Are you excited to get started with the labs?** Please head over to the first lab on [Operational Modernization](../operational-modernization/README.md).
