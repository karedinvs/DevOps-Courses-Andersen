## Flask app with Ansible deployment

### Tasks to do:
* create an ansible playbook that deploys the service to the VM
* make sure all the components you need are installed and all the directories for the app are present
* configure systemd so that the application starts after reboot
* secure the VM so that our product is not stolen: allow connections only to the ports 22,80,443. Disable root login. Disable all authentication methods except 'public keys'.
* the service listens at least on port 80 (443 as an option)
* the service accepts GET and POST methods
* the service should receive `JSON` object and return strings 


To use this app you must have:

1) Installed Virtulbox with VM Debian 10 (or any VM with this OS on another vm platform for virtualisation) 
2) SSH utils there are: ssh-keygen, ssh-copy-id 
3) Installed Ansible

### VM | SSH :
For the first you must install Debian 10.
Create your keys with ssh-keygen and transfer it to the VM.
 
Add user to sudo group on the VM
```
$ su
Password:
$ sudo gpasswd -a tk sudo
Adding user tk to the group sudo
```

For the second you must edit apt sources and comment line with source cdrom

### Git:

Copy this repo with this task.
This task consists of:
```
├── README.MD                         ### Readme file
├── ansible.cfg.                      ### Config your ansible
├── app
│   └── animal.py                     ### Flask app
├── files
│   └── requirements.txt              ### Requirements for the flask app
├── inventory
│   └── hosts                         ### Describe your hosts
├── playbook.yml                      ### Main playbook
└── templates
    └── app-animals.service.j2        ### Systemd service for the app

4 directories, 7 files 
```

* Config your ansible env in ansible.cfg
* Enter values **IP address, ansible user, ssh private key, ansible sudo pass**


To run the playbook enter command:

```
ansible-playbook playbook.yml
```

To test app you can use curl with options:

 -H, --header <header/@file> Pass custom header(s) to server\
 -X, --request <command> Specify request command to use\
 -d, --data <data>   HTTP POST data


* POST request
```
curl -H "Content-Type: application/json" -X POST -d '{"animal": "dog", "sound": "gau-gau", "count" : 14}' http://10.211.55.17
```
Answer example:

```
🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau
🐕 says gau-gau

Made with 💛 by Vadim
```



Tech notes:
> App was written in PyCharm IDE\
> VM working on Parallels\
> Ansible installed\
> Testing with curl\
> System MacOS