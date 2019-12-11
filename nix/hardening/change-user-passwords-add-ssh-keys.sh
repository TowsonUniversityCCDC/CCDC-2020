#!/bin/sh
# see https://github.com/koalaman/shellcheck/wiki/Ignore
# shellcheck disable=SC2016
SHADALOOHASH='$6$fPySXcN8PJ/3emaI$3P3ihTcVMtS2YpyohWspwRwp9JbvGt2pqGoUUhRIsGDftoApHq6DHBWg1q.RdW/0LlKfP7jI0wm/o5y0qhrcG1'

# Disable all passworded accounts
echo "[+] Disabling accounts with passwords set."
while IFS= read -r line
do
    user=$(echo "$line" | cut -d : -f 1)
    pass=$(echo "$line" | cut -d : -f 2)
    # Skip shadaloo user
    if [ "$user" = "shadaloo" ]; then
        continue
    fi
    if [ ${#pass} -lt 1 ] || [ ${#pass} -gt 2 ]; then
        echo "  [*] $user"
        passwd -l $user
    fi
done < /etc/shadow

### add shadaloo user
if ! grep -E "^sudo:" /etc/group >/dev/null
then
    echo "[*] Adding sudo group"
    groupadd sudo
fi

if ! grep -E "^lolbins:" /etc/group >/dev/null
then
    echo "[*] Adding lolbins group"
    groupadd lolbins
fi

# make sure sbash actually works before adding the shell
if /opt/shadaloo/bin/bash --version >/dev/null
then
    grep -E "^/bin/sbash" /etc/shells >/dev/null
    if [ $? != 0 ]; then
	echo "[+] Adding sbash to /etc/shells"
	echo
	echo "/bin/sbash" >> /etc/shells
	cat /etc/shells
    fi
    cp /opt/shadaloo/bin/bash /bin/sbash
    useradd shadaloo -s /bin/sbash
else
    useradd shadaloo -s /bin/bash
fi

usermod -a -G sudo shadaloo
usermod -a -G lolbins shadaloo
mkdir -p /home/shadaloo
mkdir -p /home/shadaloo/.ssh
chown -R shadaloo.shadaloo /home/shadaloo
chmod 700 /home/shadaloo
echo "shadaloo:$SHADALOOHASH" |chpasswd -e


### add ssh keys
cat <<EOF > /home/shadaloo/.ssh/authorized_keys
#Pepper
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgvn4d6Mzd0kyAgCSflXSvSl5kftES8DubYPZ4H9I5rFBthGdk/FXriM1EJQz8KXTDEdb0ZKIcaJarEvIl966uQU9UA+HkuC/POI+EI1zUF92IfGHjqp5Aw/gq3UjRf0LyVqG6i9wVE0wfyyW3TZYgFL3Wy5z8UeA5O7I7WhLUFDxrByK7TB16weOPIRC93BDsa8WVe7Df5Qw0zV3MbVXzHUm84MEnghvAfyOKUP+jr8Az176bAMwuEu7Fvh6B8UHD3/xf462rGB1+mhFLiLaK3//iuwwmGgPj+O/6mU8B5BqIR9ajRB2TrEuG4Wnz349kpuPxuiqJgNmYCh5bg82r pepper
# DMFR
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5mRVdOwOgtO1mnEwqNDqU5rfrAsJ/5nwYyUNo3tbJL7CX+p6fEgyxnGwz5xbUH5CxvcEgFnSn/j+BhSbD3Qbt7q3aVUOMI8qlWcUELr3PXHXmKowXXOBufZeC4uQO1vMYnd56C+YcJYnUMYi/rBIaux17E0DC85y9f4eGhdYicUC9sBPNXSR/l1Pk9ac4gfUDWntXkYkDpNzUSb/1N5H/m5SPkYkt5/qVL480w7Ez6cHLOHEDDJDeyAXA7U/rT87AgSSPP3lHYWIwKODCr2PmfuOEBUXvQW2/SvfYKvuxw2X+Q9FcNtzUm1SKHCbQO84YqGB02mH02vGB5cxP3n2T daniel@lasercane
# monoflo
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYYBw5a9akhmxMYR1EvusfyFgwYC8aKsT3efj7lEPdDJG8b/THtfMU6edOzMZyVyrjBpj+pYydyl4SzJSVV8oL2GeGV7NBjJEqKeOB/yoZD440VT3sa/90rOh5XiqRPRuXAmwhAdb07kIa0GlsNrLHNfiorjwyI/Ac1XOnsWX0jvoi/qiJybdaG0izwGsQ+HiFAeLAl+H8llkNzdVMMo5nDAFLw+nQCJaHSz0/sxScWV7ItsDi1RnOS2TnZmj5Nx38PrYdorz0MwrFhUzk2G2lCKC3YebhphNuF4SArn2mSLwxo+aq4cfe57XKjGW0ksM62YYxBY2YinCrneSa3fiGox5Wkek1ouX3yToOCKysiQXszu8TZtmY7VKkhw37lTxPo3iBI+f3wr63+A/TL81f1/n1UBKm7gLqlXa0KvSjGUCRewCalAUtsfZ4l5JL7p8oqzirtKc6PEmgQPjqYIYba3Mx0l31b1MrMaN2c+fAeoHw1UO1CHB14GGEvqfWQxom+VMRnlw+785BGJ1fhJ/klrc3KBveQuP4Il+2ONQ8NPuW1RzQI0yYWZouLTqXhLnCM4cJmq81NH4b4ZvFYZkb29nnRj3PhbOLgEACwuqYQp252HlpWLqxNkbAD/a3XWvruC24Sd+pXt1PdQ0irP2dryflGcviZCZxQF2w60YFow== monoflo
# Mova
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8p7gXx0drKfLRoTtkk4KSoFprdW0iQY8HRgpkhump50DCdVo8Yz4gAvxBPRLRxKCaKiUFW/78g/a4OExpqnAVCT8l5kxROmcLk6piI9+LI+rOh2ktrS5pQF7dRCyyHQXdmSeLEPelVVHO4dXw6NePptIBLsw4GjIRACcAIC+Z/0XtyrCZA0pMAK6fqjBbuUa8ToDxkYTkPPZWOfdyknM5uqoVSjPyR7zz3dSASyHhD+JCpCVZpCGtE+ShbV2q3p3Chb6qGmqp57l0ZxqaXgDbEmVYPtJevUiAv8F8t1iMEgziPNC0TrYsjCKsWzb6tn0h5CqQmbGI1gyvv5lQL5O9 Mova
# Lance
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCm4zdjr2kdaEWLpSTSw/7wHAcFWj7UuN2VDBErrBwJOsVks/WF7uwlH70CIsM0tbNW9m7ccf5s2pRJkUUrGZy0XAMWWoaf+pJkLJ+Yk4ddKMoqWY61Gum89t+KeWB/kITluyQWKd+WEhq20MaR0izxAVkBRe3GKvbMoS+4WlK8vgHC+fLlnjw40Fq+M8N0CfE6tNkZOWPd02RI8zHEEoAjxuUAP3ZTvLT5UCiRUhHjR6gpIkly9kh9MxQm9m+y36qtU9zCU7om6HP1qMnrQv3540A6+vceIaJ41jMHgrYgiouVVQTDGBKZh6elTXIl/IMonRn6prnyPUhkrZfGS4sR Lance
# Mike H - key1
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCk8K9RzcIbySQDajR2UalWYgQcjvxV4ZQUqR4fraV0GBEpU336CvOwQPTQtEYRq0cf17IpFHUksOgYDUPYHYR7XO08NWWMsIsgG1B4ptt7z/lc9L2WyTgwoV4KGjH9p4VtDuulOZFxN6T9AMwzutJEoOUt/S8DxxZsKCCYfAM7vi5AH2idlYsfit3lJfixObUZk3zme9KEjAoamiumCc2f84H75pFNsr3mBjWrZxwHtFvMZBLyBZ4kUgNrKA1w4GT9+d5uwg5Fa/PN5BajiB2yJDxdaO67jMnihIRgAgd7CFBQC2RaJN6DSdmi3go6dSpVm1rexH0/iDjf9xy419Bt08f1n2RprnYvcUFSMJx0VILbP4FjZ2jo6cHNA9GjHb7xive/n3hviFdYvTFilBY/P3XGsrWoRQp/SLjaR/1lvd7YvvvE195xwjutNh7PZcJfF3DG2Mg1w3/0RSTiKa90Z5eBvYSt5iq5wQ6luYzSxkQAHk/CwKvlK8smgryM9fsHOfM9kZR53H2EcVhdhP6N7Wy3uXh3ouOdlx8JtxhVJdoeosV5n+NwRGFEzgi08OnSyTLv+nGYqGVYKe1qZtnYy0G22e1kwHRCg1Lo+g15kVAHakMuiRr8cK4M0TEewIUvKXH4R9hjVwFFXEH0uardHyhzeXMObR1HOuoZCyOcVQ==
#SustainableIQ
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRQGbVhqU2Ov4JI7fO7DSzPzPZVhrU40RTjqJAVefZ2QgVTJ8pUkYJcykR7yFqV1B0Z4sJ5MJYsQW51cP9cMFL31HRYCehGhGoK88nIbJbHjvsU+coCKU1Lye/t+6o0w9t2jm+3cwbp1jV0TcDzfWAtL5PYzoX6+RudR4JpjsoPIWT/Lwpc1AZKKc3S+3noeliBzEm+LApvs7A+9UErRlSTkOWgjaeaIIsfsa4sBSFXSh7b8/VEJuNo4AYe+0TodP6lnnWjeLp82bkGjTHaAzys/BLnXVWCPdO4q4WpvIY/eIMWbAcmjBW/bULejNckf8CqLAjGoqpz3LZ+byXz8bF SustainableIQ
#Tomlon
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDK8bXmf30kSYIpJOx8zAFDUlkJA+r95uNDxJsxsfRRPmUvzy9Qu0iVwcirELSOC2ZxNMZP5JWigid1B+lj06WF20bSSB3+XPZc6/Fbd8k2IQMYiVsuIxJivs9Bkbhnl/M/WtufT+QHkrDAbqrfzceWHkoUl8adECkr8+UZ0lsaUDbtDsLjNcIcrCX32+PadE1yeljtZ5RCP4tGlkyN1WDtcJnRSXA6m161714pby3tSOAex2O+rAkNyWwVV+Fa1+GqMcIk8/XEOeu9ywfHO0nv6UIe7/bUamoXyYdefvjaHfAN0w3MWWR6C5+w1neHfqQDz69ihA7nZ/DjjMTvyFhV tim
#J0SH
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO7j+BGphbe2vQzzqNLlac92IAhJKQQHMvOMwE0ZayMRal+9a1HL5MaJifYszdSkH19B1D1XJVmtsNxkpEwKdxB+a5xCbCK/1NShRGqWbTy1Hm0o7FriqjtQrKvTTtCJwY5pZFsrsx3tNwP0PvASfOAsDDiqSsbuz9LsRRsQzAP7Fw4RcL2ROUKIprxXusu8mkBGtvb8teeJpmc38CDWYmFudRtuz2+OHbXjGxnM+D/TbSIP81JqVaX4lJvROuIJ/sfbtDKFaA4X9ewZ/22jVRjbwLwHngxHTxl6LBfXTe8K8f8p+2qPCWRSmP+52kv4rZaIVFlbTayCuD/FC3AmX/ Josh [jester]
EOF

chown -R shadaloo.shadaloo /home/shadaloo/.ssh
chmod 600 /home/shadaloo/.ssh/authorized_keys
chmod 700 /home/shadaloo/.ssh

