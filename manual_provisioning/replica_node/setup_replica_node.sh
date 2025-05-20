#!/bin/bash

#########
    #
    #  PostgreSQL replica node
    #
    #  shell script for provisioning of a debian 12 PostgreSQL machine as replica node.
    #
    #  @package     Debian-12-Bookworm-CH
    #  @subpackage  PostgreSQL
    #  @author      Christian Locher <locher@faithpro.ch>
    #  @copyright   2025 Faithful programming
    #  @license     http://www.gnu.org/licenses/gpl-3.0.en.html GNU/GPLv3
    #  @version     alpha - 2025-05-24
    #  @since       File available since release alpha
    #
    #########

# make sure that the vagrant user belongs to the group vboxsf to access a shared folder:
# $ groups
#
# if the user doesn't belong to the group, add it:
# $ sudo usermod -a -G vboxsf vagrant

set_up_replica_node() {
    # stop postgreSQL
    sudo systemctl stop postgresql

    # setup replica node config
    sudo rm /etc/postgresql/15/main/postgresql.conf
    sudo cp /mnt/replica_node/postgresql.conf /etc/postgresql/15/main/postgresql.conf
    sudo chown postgres:postgres /etc/postgresql/15/main/postgresql.conf

    # delete everything in postgresql directory
    sudo chown -R vagrant:vagrant /var/lib/postgresql/15/main/
    sudo rm -rf /var/lib/postgresql/15/main/*
    sudo chown postgres:postgres /var/lib/postgresql/15/main/

    # create backup from primary node
    sudo -u postgres pg_basebackup -h 192.168.56.10 -U rep_user -D /var/lib/postgresql/15/main -P -Xs -R
  
    # start postgreSQL
    sudo systemctl start postgresql
}

echo "#################################"
echo "# setup PostgreSQL replica node #"
echo "#################################"
set_up_replica_node
