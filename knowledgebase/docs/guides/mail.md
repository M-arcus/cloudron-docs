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

./imapsync --gmail1 --user1 girish@forwardbias.in --password1 MASKED --host2 my.smartserver.space --user2 girish --password2 MASKED --maxbytespersecond 20000 --useheader=X-Gmail-Received --useheader Message-Id --automap --regextrans2 s,\[Gmail\].,, --skipcrossduplicates   --folderlast [Gmail]/All Mail --exclude "\[Gmail\]/Spam"

