# AppDynamics Analytics Agent for Logs

The Analytics Agent can be used within CloudFoundry to gather Log Files. [More details on how to configure Log Analytics ](https://docs.appdynamics.com/display/latest/Configuring+Log+Analytics)

To deploy the Application to CloudFoundry the [Dist Zip Container](https://github.com/cloudfoundry/java-buildpack/blob/master/docs/container-dist_zip.md) of the [Java Buildpack](https://github.com/cloudfoundry/java-buildpack) is used.

## Build and Deploy the Agent
1. [Alter the configuration as per documentation](https://docs.appdynamics.com/display/latest/Installing+Agent-Side+Components)
  * Change `cf.job`
2. Build a Docker Image for the Log Analytics Agent
  * by `./build_docker.sh <Portal User> <Agent Version X.X.X.X>`
  * Will Prompt for:
   * Event Service Host Name
   * Event Service Port
   * Account Access Key
   * Global Account Name
   * Docker Image Name
   * Portal Password
3. Run your Docker Container
  * by `docker run --name <Container Name> -v <Host Java Home>:/java -p <Host Port>:514 -d <Image Name>:<Version>`

## Deploy

1. Create a User Provided Service to pass logs from an App to the Log Analytics Agent
  * by `cf cups <Log Analytics Service Name> -l syslog://<Log Analytics Agent Host>:<Port>`
2. Restage your App so the changes take effect
  * by `cf restage <Application Name>`
