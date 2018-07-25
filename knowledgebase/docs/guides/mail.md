https://imapsync.lamiral.info/dist/

https://github.com/imapsync/imapsync/blob/master/FAQ.d/FAQ.Gmail.txt

[INBOX]
[[Gmail]]
[[Gmail]/All Mail]
[[Gmail]/Drafts]
[[Gmail]/Important]
[[Gmail]/Sent Mail]
[[Gmail]/Spam]
[[Gmail]/Starred]
[[Gmail]/Trash]
[app-releases]
[github]
[info]
[intel]

Gmail users
-----------
./imapsync --gmail1 --user1 girish@forwardbias.in --password1 MASKED --host2 my.smartserver.space --user2 girish --password2 MASKED --maxbytespersecond 20000 --useheader=X-Gmail-Received --useheader Message-Id --automap --regextrans2 s,\[Gmail\].,, --skipcrossduplicates   --folderlast [Gmail]/All Mail --exclude "\[Gmail\]/Spam"


General flow
-------------
1. setup Cloudron at my.domain.com
2. enable email. (do not need to setup MX record at this point. just need the mail server enabled. currently, cloudron setup updates it though with programmable dns)
3. create mailbox
4. import using above command
do 3,4 for every user/mailbox
5. then fix MX record to cloudron 
