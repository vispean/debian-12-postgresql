#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

#########
    #
    #  PostgreSQL primary node
    #
    #  shell script for provisioning of a debian 12 PostgreSQL machine as primary node.
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

function setUpPrimaryNode {
    # create replication user
    sudo -u postgres psql -c "CREATE USER rep_user WITH REPLICATION ENCRYPTED PASSWORD 'rep_pw';"

    # stop postgreSQL
    systemctl stop postgresql

    # create archive directory
    chown root:root /var/lib/postgresql/15/main
    mkdir /var/lib/postgresql/15/main/archive
    chown -R postgres:postgres /var/lib/postgresql/15/main

    # setup primary node config
    rm /etc/postgresql/15/main/postgresql.conf
    cp /vagrant/auxiliary_files/postgresql/primary_node/postgresql.conf /etc/postgresql/15/main/postgresql.conf
    rm /etc/postgresql/15/main/pg_hba.conf
    cp /vagrant/auxiliary_files/postgresql/primary_node/pg_hba.conf /etc/postgresql/15/main/pg_hba.conf

    # start postgreSQL
    systemctl start postgresql    
}

echo "#################################"
echo "# setup PostgreSQL primary node #"
echo "#################################"
setUpPrimaryNode
