# Login to OpenShift using web terminal

1. Follow the steps [here](web-terminal.md) to access the web terminal. If you already have the web terminal opened, then use that.

1. From the Openshift console, click on the twisty next to your login name and select `Copy Login Command`.

    ![Copy Login Command](https://github.com/IBM/openshift-workshop-was/blob/master/labs/Openshift/IntroOpenshift/images/CopyLoginCommand.jpg?raw=true)

1. In the new window that pops up, click on `Display Token`:

    ![Display Token](https://github.com/IBM/openshift-workshop-was/blob/master/labs/Openshift/IntroOpenshift/images/DisplayToken.jpg?raw=true)

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
