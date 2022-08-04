# Free Cloud Compute
Initialize an instance using GitHub Actions, hold the workflow, and connect to it remotely via SSH or RDP (Windows).

Remote connection is made possible by [ntop/n2n](https://github.com/ntop/n2n) and [fatedier/frp](https://github.com/fatedier/frp). 

*Notice: the instance will last for at most 6 hours due to restrictions made by GitHub.*

To get your own free cloud compute instances, fork this repository and do the following.

## Preparations for remote connection
The instance that is initialized by GitHub Actions does not have a public ip address. This calls for Intranet penetration tools. 

Currently, N2N and FRP are supported. 

*Notice: N2N is not supported on MacOS.*

### Use N2N
N2N requires two elements to work: edge nodes and a supernode.

A supernode allows edge nodes to announce and discover other nodes. It must have a port publicly accessible on internet. 

Edge nodes are part of the virtual networks, or a _community_. The instance that is initialized by GitHub Actions runs N2N edge (v3) automatically.

**You will need...**
1. A supernode. You can build a supernode on a server with a public ip address or simply find public supernodes provided by others.
2. To run edge on your personal computer. With edge nodes on the remote instance and your computer that are brought together by the same supernode, you can access the remote instance directly, since both computers are in the same virtual network.

For more information, please visit [ntop/n2n](https://github.com/ntop/n2n).

*Notice: the version of both supernode and edge nodes should be `n2n_v3` or above.*

**What you should do before connecting to the instances:**
1. Find an available supernode and set up supernode info on GitHub.
Add the following GitHub Actions repository secrets:
    - `N2N_SUPERNODE_HOST`: the host or ip address of the supernode.
    - `N2N_SUPERNODE_PORT`: the port of the supernode.
2. Set up edge info. The instance will use the information below to join the virtual network.
Add the following GitHub Actions repository secrets:
    - `N2N_COMMUNITY`: the community name of intranet created by N2N. It can be arbitrarily assigned unless the supernode has restrictions.
    - `N2N_KEY`: the secret key for AES encryption. It can be set arbitrarily.
3. Run edge and connect to the supernode on your personal computer.
   1. Install Tap Adapter. You may search `install tap adapter` on your favourite search engine for more information.
   2. Go to [lucktu/n2n](https://github.com/lucktu/n2n) to download the compiled binary programs of edge.
   3. Change directory to where edge is located, and start edge on your own computer with the following command:
      ```shell
      ./egde -c <N2N_COMMUNITY> -l <N2N_SUPERNODE_HOST>:<N2N_SERVER_PORT> -a <LOCAL_INTRANET_IP> -k <N2N_KEY> -A3
      ```
      Please replace variables (surrounded with <>) with corresponding values and remove brackets.
### Use FRP
FRP has two elements: FRPC (client) that runs on the instance and FRPS (server) that runs on a server with a public ip address. 

When you access a certain port on the computer running FRPS, the data is then routed to a certain port of the computer that runs FRPC.

Fortunately, you will not need to run anything on your own computer.

Unfortunately, you will have to assign different ports for every service on the instance. But do not worry, this repository has done everything.

**You will need...**
1. A server that runs FRPS. It would be better when the version of FRPS is above or equal to `v0.44.0`.

*Notice: a token for authentication is mandatory for security reasons. Please make sure that the FRPS needs a token.*

**What you should do before connecting to the instances:**
1. Set up FRP info and token.
Add the following GitHub Actions repository secrets:
    - `FRP_SERVER_ADDR`: the server host or address of FRPS.
    - `FRP_SERVER_PORT`: the server port of FRPS for connections with FRPC
    - `FRP_TOKEN`: token for authentication (specified in the config file of FRPS).
### Other preparations
- Personal SSH public key
  You can add persoanl SSH public keys to the instances so that you may use public key to authorize SSH login.
  To deploy personal public keys, please do the following.
  1. Generate an SSH key pair using command `ssh-keygen`. Ignore this step and proceed if you have already have a pair.
  2. Copy all contents from file `id_rsa.pub` or public key files (`*.pub`) with other names. This is your public key.
  3. Add this GitHub Actions repository secret:
      - `SSH_PUBKEY`: the public key you want to add. If you need more than one public key, paste one key per line.

## Initialize an instance
Go to `Actions` page of the repository and choose the workflow of your desired operation system before running GitHub Actions. 
### General steps
1. Click on `Run workflow` button.
2. Fill in the information.
3. Click on the green `Run workflow` button.
4. Refresh the page and view logs of job `Initialize XXXXXX-Latest Instance`.
5. Wait until the job proceeds to `Maintaining` step.
6. Connect to the instance.

The specific step of filling information varies with the operating system.

### Ubuntu
- Identifier
This label is used for instances to announce and distinguish themselves with other instances. Choose arbitrarily but reasonable.
- N2N
You need to decide whether N2N edge is used. 
If so, you also need to assign the remote ip address for the instance. This will be referred to later as `N2N_IP`.
*Notice: this is different from the local ip address that you assigned on your own computer.*
- FRP
You need to decide whether FRPC is used. 
If so, you also need to Specify the remote SSH port for FRP. This will be referred to later as `FRP_SSH_PORT`.
- Personal SSH public key
You may deploy your persoanl SSH public key for authentication. Make sure that the corresponding secret has been added to the repository. 
- Static host key
Normally, the host key changes each time an instance is initialized. You have to manually delete the related information in the local file `~/.ssh/known_hosts` otherwise the connection is refused to prevent man-in-the-middle attack. If you choose to deploy a static host key, the host key will remain the same each time an instance is initialized and it makes it easier for you to connect.

### Windows
- Identifier
This label is used for instances to announce and distinguish themselves with other instances. Choose arbitrarily but reasonable.
- N2N
You need to decide whether N2N edge is used. 
If so, you also need to assign the remote ip address for the instance. This will be referred to later as `N2N_IP`.
*Notice: this is different from the local ip address that you assigned on your own computer.*
- FRP
You need to decide whether FRPC is used. 
If so, you also need to Specify the remote SSH port for FRP and the remote RDP port for FRP. These will be referred to later as `FRP_SSH_PORT` and `FRP_RDP_PORT`.
- Personal SSH public key
You may deploy your persoanl SSH public key for authentication. Make sure that the corresponding secret has been added to the repository. 
- Static host key
Normally, the host key changes each time an instance is initialized. You have to manually delete the related information in the local file `~/.ssh/known_hosts` otherwise the connection is refused to prevent man-in-the-middle attack. If you choose to deploy a static host key, the host key will remain the same each time an instance is initialized and it makes it easier for you to connect.

### MacOS
- Identifier
This label is used for instances to announce and distinguish themselves with other instances. Choose arbitrarily but reasonable.
- FRP
You need to decide whether FRPC is used. 
If so, you also need to Specify the remote SSH port for FRP. This will be referred to later as `FRP_SSH_PORT`.
- Personal SSH public key
You may deploy your persoanl SSH public key for authentication. Make sure that the corresponding secret has been added to the repository. 
*Notice: you can only use publickeys to authenticate and login to SSH on MacOS.*
## Connect to the instances
If you see a variable surrounded by angle brackets like `<variable>`, replace the brackets and the variable with the corresponding value.

If you see something surrounded by square brakets like `[expression]`, you can decide whether to keep or ignore the expression based on your condition.

If you see something separated by pipe character and surrounded by angle brackets like `<A|B>`, you will need to choose one to keep. 
*Notice: in this case, neither of A and B is surrounded by brackets directly, so keep them as they are.*
### Ubuntu
- General info
  - Users
    - User: `root`
      - Description: super admin account
      - Password: (None)
    - User: `runner`
      - Description: the account that GitHub Actions use to run workflows. It can run `sudo` without passwords.
      - Password: (None)
  - SSH service
    - Port: `22` (default)
    - PermitRootLogin: `yes`
    - PermitEmptyPasswords: `yes`
- Connect via SSH
  - Use N2N
    ```shell
    ssh <root|runner>@<N2N_IP> [-i </path/to/your/privkey/named/id_rsa>]
    ```
  - Use FRP
    ```shell
    ssh <root|runner>@<FRP_SERVER_ADDR> -p <FRP_SSH_PORT> [-i </path/to/your/privkey/named/id_rsa>]
    ```
### Windows
- General info
  - Users
    - User: `runneradmin`
      - Description: built-in admin account (name changed from `Administrator`), the account that GitHub Actions use to run workflows. It can run programs as admin without UAC.
      - Password: (None)
      *Notice: if you login with this account remotely with RDP, do not try to close the command window on the desktop, otherwise the workflow is terminated and the instance is destroyed.*
    - User: `root`
      - Description: a new admin account. 
      - Password: (None)
      *Notice: since the user profile has not been initialized when you first login with this newly added account, it may take a long time for the instance to prepare user files. **Connect first with RDP is recommended.***
  - Security policies
    - Require complex passwords: `no`
    - Deny remote login with users that has blank passwords: `no`
  - SSH service
    - Port: `22` (default)
    - PermitEmptyPasswords: `yes`
  - RDP service
    - Port: `3389` (default)
- Connect via SSH
  - Use N2N
    ```shell
    ssh <runneradmin|root>@<N2N_IP> [-i </path/to/your/privkey/named/id_rsa>]
    ```
  - Use FRP
    ```shell
    ssh <runneradmin|root>@<FRP_SERVER_ADDR> -p <FRP_SSH_PORT> [-i </path/to/your/privkey/named/id_rsa>]
    ```
- Connect via RDP
  - Use N2N
    - Computer: `<N2N_IP>`
    - Username: `runneradmin` or `root`
    - Password: (None)
    - Port: `3389`
  - Use FRP
    - Computer: `<FRP_SERVER_ADDR>`
    - Username: `runneradmin` or `root`
    - Password: (None)
    - Port: `FRP_RDP_PORT`
### MacOS
- General info
  - Users
    - User: `root`
      - Description: super admin account
      - Password: (Unset and unknown)
      *Notice: public keys are not set for root.*
    - User: `runner`
      - Description: the account that GitHub Actions use to run workflows. It can run `sudo` without passwords.
      - Password: (Unset and unknown)
      *Notice: you can only use public keys for authentication.*
  - SSH service
    - Port: `22` (default)
    - PermitRootLogin: `yes`
    - PermitEmptyPasswords: `yes`
    - PasswordAuthentication `no`
- Connect via SSH
  - Use N2N
    ```shell
    ssh <runner>@<N2N_IP> -i </path/to/your/privkey/named/id_rsa>
    ```
  - Use FRP
    ```shell
    ssh <runner>@<FRP_SERVER_ADDR> -p <FRP_SSH_PORT> -i </path/to/your/privkey/named/id_rsa>
    ```
