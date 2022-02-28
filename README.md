Grafana + InfluxDB over Kubernetes
==================================

Depending on the site to be deployed, it will install either it-grafana.ls.lsst.org or it-grafana.cp.lsst.org

Grafana+InfluxSB Deployment
---------------------------

```

First, install influxdb by using the deploy.sh script inside the site you want to deploy.
Once is up and running (wait condition of the following command is met), will need to
provision influxdb with a database and a username, which has been written into init_influxdb.sh

```bash
cd it/ls/influxdb
./deploy.sh
./init_influxdb.sh
```

Once the installation/Initialization of influx is done, proceed with the deployment of Grafana.
This installation has already been configured so it connects with influxdb upon the first run:

```bash
cd it/ls/grafana
./deploy.sh
./init_grafana.sh
```

Charts Depoyment
----------------

In order to deploy the charts, the resources folders must be created:

```bash
cd it/ls/grafana/resources
./folders_generator.sh
```

Now that the folder's ID are stored, the servers, services, and clusters may be deployed:

```bash
cd it/ls/grafana/resources/clusters
./cluster.sh
```

```bash
cd it/ls/grafana/resources/services
./cluster.sh
```

```bash
cd it/ls/grafana/resources/servers
./servers.sh
```

Uninstall
---------

To delete everything, run the undeploy.sh script in both folders, and then delete the namespaces:

```bash
it/ls/influxdb/undeploy.sh
it/ls/grafana/undeploy.sh
kubectl delete ns it-influxdb
kubectl delete ns it-grafana
```
