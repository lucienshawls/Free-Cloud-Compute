# Free Cloud Compute
Initialize an instance using GitHub Actions, pause the workflow, and connect to it remotely via SSH, RDP (Windows) or VNC (MacOS).

The Instance is connected remotely with the help of ntop/n2n. Pay attention, the connection stays for at most 6 hours due to the restrictions made by GitHub.

To get your own free cloud compute instances, fork this repository and do the following.

## Set up supernode info
Generate the following GitHub Actions secrets:
- <N2N_SUPERNODE_HOST>: the host or ip address of a supernode.
- <N2N_SUPERNODE_PORT>: the corresponding port of a supernode.

## Set up edge info
Generate the following GitHub Actions secrets:
- <N2N_COMMUNITY>: the community name of intranet created by n2n.
- <N2N_KEY>: the secret key for AES encryption.

## Connect to supernode locally
Install n2n and tap driver first, change directory to where edge is located, and then start edge with the following command:
```shell
./egde -c <N2N_COMMUNITY> -l <N2N_SUPERNODE_HOST>:<N2N_SERVER_PORT> -a <local intranet ip> -k <N2N_KEY> -A3
```
Please replace variables (surrounded with <>) with your own settings.

## Initialize an instance
Choose the operation system before running GitHub Actions. Remember to input the ip address mentioned later as <IP>.

Notice that the instance will last for at most 6 hours.

## Connect to the instances
- via SSH (ALL)
  ```shell
  ssh root@<IP>
  ```
  Passwords for root have been removed.
- via RDP (Windows)
  - Computer: <IP>
  - Username: <root>
  - Password: None