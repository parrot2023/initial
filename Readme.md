Here are the steps you will need to make macchanger.sh load on startup:

    1. Either load a root shell (sudo bash) or prefix most of the commands with sudo to run as root.

    2. Move the macchanger.sh file in /usr/local/sbin. Let's call it /usr/local/sbin/macchanger.sh (as root):

        mv ${PWD}/macchanger.sh /usr/local/sbin/macchanger.sh

       (Assuming editor launches your preferred editor and it creates the file if it does not exist.)

    3. Then make the file only read/write/executable by root (for security):

        chmod 0700 /usr/local/sbin/macchanger.sh

    4. Create the systemd unit file 
       (Usually in /etc/systemd/system, but there are other locations; the link above gives more detail):

        sudo nano /etc/systemd/system/macchanger_on_start.service

       In the editor for that file, put:

        [Unit]
        Description=Changes MAC Address of All Available Interfaces
        [Service]
        ExecStart=/usr/local/sbin/macchanger.sh
        [Install]
        WantedBy=multi-user.target


    5. Save and exit the editor. Test the unit:

        systemctl start macchanger_on_start.service

    6. If all went well and from (a non-root) shell, enable the unit to start on boot:

        systemctl enable macchanger_on_start.service

Go ahead then and reboot, and make sure it's all working now.

If needed, you can also systemctl disable macchanger_on_start.service to make it stop running at boot.
