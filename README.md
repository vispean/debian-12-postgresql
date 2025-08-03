# Debian 12 PostgreSQL
Provisioning of two debian 12 machines with PostgreSQL and a replication between the two

## Build virtual machine in virtualbox

- see https://github.com/vispean/debian-12-lamp section with the same title

## Options within Vagrantfile

- see https://github.com/vispean/debian-12-lamp section with the same title

## Windows remarks

- see https://github.com/vispean/debian-12-lamp section with the same title

## Connect to PostgreSQL
- to get the ip address of the guest machine run on the guest machine the following command: `ip addr show`
- open the browser on the host machine
- enter http://`<insert guest ip address>`/pgadmin4 (for example: http://192.168.56.10/pgadmin)
- email: vagrant@vagrant.com
- password: vagrant
