Grafana + InfluxDB over Kubernetes
==================================

This template has already been configured to work with the URL comcam-grafana.ls.lsst.org.

Sources
-------

The Grafana and Influxdb charts can be obtained from:

```bash
helm repo add influxdata https://helm.influxdata.com/
helm repo add grafana https://grafana.github.io/helm-charts
```

Clean Install
-------------

If you require a clean install/template, I recommend grab the template from helm:

```bash
helm template grafana -n comcam-grafana grafana/grafana -f values
helm template influxdb -n comcam-influxdb influxdata/influxdb -f values
```

Deployment
----------

Depending on the site and instance, you must browse into the folder first.
i.e Comcam Grafana and InfluxDB -> comcam/grafana and comcam/influxdb respectively

Start by cloning the repo into a local folder:

```bash
git clone https://github.com/lsst-it/gi-k8s.git
```

First, install influxdb by using the deploy.sh script inside the site you want to deploy.
Once is up and running (wait condition of the following command is met), will need to
provision influxdb with a database and a username, which has been written into init_influxdb.sh

```bash
cd gi-k8s/comcam/influxdb
./deploy.sh
./init_influxdb.sh
```

Once the installation/Initialisation of influx is done, proceed with the deployment of Grafana.
This installation has already been configured so it connects with influxdb upon the first run:

```bash
cd gi-k8s/comcam/grafana
./deploy.sh
./init_grafana.sh
```

Uninstall
---------

To delete everything, run the undeploy.sh script in both folders, and then delete the namespaces:

```bash
gi-k8s/comcam/influxdb/undeploy.sh
gi-k8s/comcam/grafana/undeploy.sh
kubectl delete ns comcam-influxdb
kubectl delete ns comcam-grafana
```
