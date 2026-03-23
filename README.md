# Deploy Wazuh Docker in single node configuration

This deployment is defined in the `docker-compose.yml` file with one Wazuh manager containers, one Wazuh indexer containers, and one Wazuh dashboard container. It can be deployed by following these steps: 

1) Increase max_map_count on your host (Linux). This command must be run with root permissions:
```
$ sysctl -w vm.max_map_count=262144
```
2) Load the images
```
docker load -i wazuh_full_stack.tar
```
3) Start the environment with docker compose:

- In the foregroud:
```
$ docker compose up
```
- In the background:
```
$ docker compose up -d
```
