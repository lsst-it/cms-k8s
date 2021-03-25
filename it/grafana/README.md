#####################################
##  Author:   Heinrich Reinking E. ##
##  Date:     March 21st 2021      ##
#####################################

Script Usage:
=============

Deploy everything, recommended for clean grafana install. This deploys the folders, generate subfiles and dashboards - for servers, clusters and services -.
.. code-block:: bash
  ./resources/deploy_all.sh

Deploy Grafana Folders:
.. code-block:: bash
  ./resources/folders_generator.sh

Deploy Cluster's Dashboards
.. code-block:: bash
  ./resources/clusters/deploy_dashboards.sh

Deploy Generic Dashboards
.. code-block:: bash
  ./resources/generic/deploy_dashboards.sh

Deploy all Server's resources: generate server's list, JSON files and dashboards
.. code-block:: bash
  ./resources/servers/deploy_servers.sh

Generate Server's JSON files
.. code-block:: bash
  ./resources/servers/json_generator.sh

Deploy Server's Dashboards
.. code-block:: bash
  ./resources/servers/deploy_dashboards.sh

Fetch Foreman server's list
.. code-block:: bash
  ./resources/servers/serverlist_generator.sh

Deploy Services Dashboards
.. code-block:: bash
  ./resources/services/deploy_dashboards.sh

Template used to generate the Server's JSON files
.. code-block:: bash
  ./resources/servers/server_template.json
