# my-services

## duckdns@.service duckdns@.timer
This service is for a dynamic DNS.
You need to registrate at http://www.duckdns.org, choose a domainname and get a token.

Create a new directory 
    mkdir /etc/duckdns.conf.d/

If you choose exampledomain.duckdns.org, you need "exampledomain" for the next steps as DOMAINNAME
When you have registrated your new domain, you see the token on duckdns.org. Take this token.

Create a new file
    export DOMAINNAME=exampledomain
    editor /etc/duckdns.conf.d/DOMAINNAME.conf

Fill in
    TOKEN=token-which-contains-many-numbers-and-charakters-abc345-322-example

and save and close this file.

Activate the timer to update your dynamic DNS-Entry
    sudo systemctl enable --now duckdns@$DOMAINNAME.timer
