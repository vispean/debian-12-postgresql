#!/bin/bash

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
    #  @version     alpha - 2025-05-24
    #  @since       File available since release alpha
    #
    #########

# make sure that the vagrant user belongs to the group vboxsf to access a shared folder:
# $ groups
#
# if the user doesn't belong to the group, add it:
# $ sudo usermod -a -G vboxsf vagrant

set_up_primary_node() {
    # create replication user
    sudo -u postgres psql -c "CREATE USER rep_user WITH REPLICATION ENCRYPTED PASSWORD 'rep_pw';"

    # stop postgreSQL
    sudo systemctl stop postgresql

    # create archive directory
    sudo chown vagrant:vagrant /var/lib/postgresql/15/main
    sudo mkdir /var/lib/postgresql/15/main/archive
    sudo chown postgres:postgres /var/lib/postgresql/15/main

    # setup primary node config
    sudo rm /etc/postgresql/15/main/postgresql.conf
    sudo cp /mnt/primary_node/postgresql.conf /etc/postgresql/15/main/postgresql.conf
    sudo chown postgres:postgres /etc/postgresql/15/main/postgresql.conf
    sudo rm /etc/postgresql/15/main/pg_hba.conf
    sudo cp /mnt/primary_node/pg_hba.conf /etc/postgresql/15/main/pg_hba.conf
    sudo chown postgres:postgres /etc/postgresql/15/main/pg_hba.conf

    # start postgreSQL
    sudo systemctl start postgresql    
}

echo "#################################"
echo "# setup PostgreSQL primary node #"
echo "#################################"
set_up_primary_node
