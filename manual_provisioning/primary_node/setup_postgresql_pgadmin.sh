#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

#########
    #
    #  PostgreSQL
    #
    #  shell script for provisioning of a debian 12 machine with PostgreSQL and pgAdmin.
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

set_up_postgresql() {
    # update system
    sudo apt-get update
    sudo apt-get full-upgrade -y

    # install PostgreSQL
    sudo apt-get install -y postgresql

    # make PostgreSQL autostart after boot
    sudo systemctl enable postgresql

    # setup password for user postgres
    sudo -u postgres psql -c "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';"
}

set_up_pgadmin() {
    # add the pgAdmin4 repository
    sudo apt-get install -y curl
    curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
    sudo apt-get purge -y curl
    sudo touch /etc/apt/sources.list.d/pgadmin4.list
    sudo chmod o+w /etc/apt/sources.list.d/pgadmin4.list
    echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list
    sudo chmod o-w /etc/apt/sources.list.d/pgadmin4.list    

    # install pgAdmin4
    sudo apt-get update
    sudo apt-get install -y pgadmin4-web

    # setup pgAdmin4
    sudo -s bash << EOF
        export PGADMIN_SETUP_EMAIL="vagrant@vagrant.com"
        export PGADMIN_SETUP_PASSWORD="vagrant"
        /usr/pgadmin4/bin/setup-web.sh --yes
EOF
}

echo "####################"
echo "# setup PostgreSQL #"
echo "####################"
set_up_postgresql

echo "#################"
echo "# setup pgAdmin #"
echo "#################"
set_up_pgadmin
