Version 4.0.2

You will find the file needed to deploy it for testing in resources/

Command to run it on localhost:55555 (with mgrep installed in /opt/mgrep, and it's files in /srv/mgrep)
```shell
/opt/mgrep/mgrep  --port=55555 -f /srv/mgrep/mgrep-55555/dict -w /srv/mgrep/word_divider.txt -c /srv/mgrep/CaseFolding.txt
```

To test if mgrep is working

```shell
telnet localhost 55555
ANY term_in_dictionary
```

This should return something (with the ID linked to the term in the dictionary)
