# AppDynamics Analytics Agent for Logs to deploy as CloudFoundry App

The Analytics Agent can be used within CloudFoundry to gather Log Files. [More details on how to configure Log Analytics ](https://docs.appdynamics.com/display/latest/Configuring+Log+Analytics)

To deploy the Application to CloudFoundry the [Dist Zip Container](https://github.com/cloudfoundry/java-buildpack/blob/master/docs/container-dist_zip.md) of the [Java Buildpack](https://github.com/cloudfoundry/java-buildpack) is used.

## Prepare
1. Download the Analytics Agent you want to use by
  * by `./get-agent.sh <Portal User> <Agent Version X.X.X.X>` (Will Prompt for Password)
    * The Download Script will also enable the Analytics Monitor `monitor.xml`
  * by downloading manually and unzipping to this directory
2. [Alter the configuration as per documentation](https://docs.appdynamics.com/display/latest/Installing+Agent-Side+Components)
  * Change `conf/analytics-agent.properties`

## Deploy

1. Deploy the Agent to CloudFoundry
  * by `cf push <Log Analytics Agent Name>`
2. Create a User Provided Service to pass logs from an App to the Log Analytics Agent
  * by `cf cups <Log Analytics Service Name> -l syslog://<Log Analytics Agent Host>:<Port>`

## Clean

1. Use `./clean.sh` to delete the Agent files
