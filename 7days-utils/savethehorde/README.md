savethehorde
===========
Saves server status and horde activity if all players log out on 7th night

**Usage**
======== 
   - Run this on the local Linux distro hosting a dedicated 7 Days server with systemd managing system services. 

**Assumptions**
=============
   - User = 7days

   - Application script directory = /home/7days/7days-utils/

   - Systemd service location = /etc/systemd/system/7days-watcher.service

   - Night hours are 22:00 to 06:00
```
Hoard monitoring is currently tested and working on a dedicated MP Survival on alpha 14.5
running on virtualized Linux (x86_64 Fedora 23). The savethehorde application interfaces with
the 7 Day to Die game console using expect to monitor specific behavior to ensure game mechanics 
integrity by triggering time adjustments to ensure blood moon horde spawns occurs. 

This prevents a problem of allowing players to skip the 7th day horde. Players currently have 
the ability to coordinate log outs on the dedicated server to bring the population to zero 
stopping the server time (normal desired behavior) and despawning the blood moon 7th day horde
to never to be seen again (not desired behavior).

Creation of a systemd service is required and assumes the dedicated 7 Days to Die server is
running on Linux and connecting to the 7 Days console using telnet without a password originating
as a local connection only. In the future it will be possible to run this application remotely to centrally 
manage multiple 7 Days to Die servers behavior however currently it assumes that you’ve locked things down 
with iptables blocking remote telnet connections and you’re only connecting locally via localhost to using
telnet to the 7 Days game console. 

The savethehorde application is only recently possible due to a recent patch by Fun Pimps to 7 Days to Die.
Below are excepts from the patch notes on alpha 14.4 which allows hordes to be reset:

...
Fixed: Feral night horde day wraps correctly.
…

Interesting enough it still seems that the below alpha 14.4 reported fix doesn’t work properly when 
it comes to the 7th Day horde. Bug request pending, however savethehorde fixes this issue by resetting
the day back to slightly before the night time triggers and then saves the world time which resolves
the issue.

Alpha: 14.4
...
Fixed: If players logout during horde, horde zombies are not saved but the horde will spawn again as
soon as someone joins.
…

More to come ...

To do:

   - Modifications to accept arguments to change the night times to user defined values definable 
in the systemd service
