### HW1
Transform script by condition from task
```
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | 
while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```

Command from this script to do:

1) sudo netstat -tunapl - show all open TCP|UDP connections
2) awk '/firefox/ {print $5}' - select port or process name
3)  cut -d: -f1 - shows only ip address
4) sort  - sort ip adds
5) uniq -c - shows uniq ip adds with count
6) tail -n5 - shown n lines
7) grep -oP '(\d+\.){3}\d+' - assembly of the IP address by mask
8) do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done  - whois loop for any ip from output netstat with select organisation


To use the script:

- Without sudo:
```
tk@ans-vm1-ubuntu:~$ ./script.sh firefox
```

![image](https://user-images.githubusercontent.com/78742638/122031419-5d2fab80-cdd7-11eb-857b-d48014188d2b.png)


- With sudo: 
```
tk@ans-vm1-ubuntu:~$ sudo ./script.sh firefox
```

![image](https://user-images.githubusercontent.com/78742638/122031529-78022000-cdd7-11eb-963c-d2d9a86826fe.png)
