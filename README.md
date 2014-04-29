remote_ssh
==========

Type SSH commands locally without needing remote server to send back each individual key stroke to avoid console lag on slow connections.

Just run ./control.rb and follow the menu instructions.

This is unsupported but may be useful for someone in a similar situation.

## Limitations

* Autocomplete does not work (pressing TAB in SSH)
* You need to authenticate by SSH key and ensure that server is added to known_hosts before starting this app. 
* Ctrl-c will quit out of the script


## Requirements

Ruby 1.9.3


