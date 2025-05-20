#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

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
    #  @version     alpha - 2025-05-23
    #  @since       File available since release alpha
    #
    #########

function setUpReplicaNode {
    # stop postgreSQL
    systemctl stop postgresql

    # setup replica node config
    rm /etc/postgresql/15/main/postgresql.conf
    cp /vagrant/auxiliary_files/postgresql/replica_node/postgresql.conf /etc/postgresql/15/main/postgresql.conf

    # delete everything in postgresql directory
    chown -R vagrant:vagrant /var/lib/postgresql/15/main/
    rm -rf /var/lib/postgresql/15/main/*
    chown postgres:postgres /var/lib/postgresql/15/main/

    # create backup from primary node
    sudo -u postgres pg_basebackup -h 192.168.56.10 -U rep_user -D /var/lib/postgresql/15/main -P -Xs -R
  
    # start postgreSQL
    systemctl start postgresql
}

echo "#################################"
echo "# setup PostgreSQL replica node #"
echo "#################################"
setUpReplicaNode
