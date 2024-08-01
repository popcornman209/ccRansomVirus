# popcornVirus
this is a virus that disables all inputs and disk booting, its theoreticallt impossible to remove without server permisions, but you can enable 3 different unlock methods.
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
is activated by a device broadcasting a signal. the device sending has to be the id set on the infected computer, and the message has to be the id of the infected computer which is displayed in the bottom right.<br />
i would not recommend using this if other players in the server are good at cc, reason being you are able to spoof id's meaning if someone knew which id could unlock the computer or just brute forced it they could unlock it.
### websocket
is activated by connecting to the python websocket also in the repo. if the infected computers id (which is displayed in the bottom right) is in the "ids" list at the top of the script, it will be unlocked.
### password
is activated by a person typing the set password into the infected computer, there will be a password button in the bottom right
