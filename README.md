# popcornVirus
this is a virus that disables all inputs and disk booting, and makes it impossible to remove without using any of the 3 unlock methods.
# setup
to install just run the below code on the device, it will bring you through the steps.
```
wget https://raw.githubusercontent.com/popcornman209/ccRansomVirus/main/virus.lua
virus.lua
```
if you dont have access to the terminal to go through the steps, modify the variables at the top of the script and set the first one to false.
# "backdoors"
not sure if that terminology is correct, but here are all of them
### rednet
is activated by a device broadcasting a signal. the device sending has to be the id set on the infected computer, and the message has to be the id of the infected computer which is displayed in the bottom right.
### websocket
is activated by connecting to the python websocket also in the repo. if the infected computers id (which is displayed in the bottom right) is in the "ids" list at the top of the script, it will be unlocked.
### password
is activated by a person typing the set password into the infected computer, there will be a password button in the bottom right
