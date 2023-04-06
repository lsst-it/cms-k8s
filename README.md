Deprecation Notice
==================

This repo is **DEPRECATED** and all configuration should be migrated to [`lsst-it/k8s-cookbook`](https://github.com/lsst-it/k8s-cookbook).

Centralized Monitoring System over Kubernetes
==================================

Depending on the site to be deployed, it will install graylog, grafana, influxdb, telegraf, kube-prometheus and/or fluent-bit

Grafana+InfluxDB Deployment
---------------------------

Install influxdb by using the deploy.sh script inside the site you want to deploy.
Once is up and running (wait condition of the following command is met), will need to
provision influxdb with a database and a username, which has been written into init_influxdb.sh

```bash
cd it/ls/influxdb
./deploy.sh
./init_influxdb.sh
```

Once the Installation/Initialization of influx is done, proceed with the deployment of Grafana.
This installation has already been configured so it connects with influxdb upon the first run:

```bash
cd it/ls/grafana
./deploy.sh
./init_grafana.sh
```
Graylog-Stack Deployment
------------------------

In order to deploy the graylog stack (Graylog + MongoDB + Elasticsearch), move into the folder
and run the deploy.sh script:

```bash
cd it/ls/graylog-stack
./deploy.sh
```

Fluent-bit Deployment
------------------------

To deploy fluent-bit, move into the folder and run the deploy.sh script:

```bash
cd it/cp/fluent-bit
./deploy.sh
```
Charts Deployment
-----------------

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
it/ls/graylog-stack/undeploy.sh
kubectl delete ns it-influxdb
kubectl delete ns it-grafana
kubectl delete ns graylog
```
