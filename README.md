A tool to discover where a chef attribute is being set from.

#description
At some point or another when working with chef you'll end up in a situation
where it's necessary to unravel how or why a particular attribute is set on a
node a certain way. At which point you'll find yourself on a journey through
comparingt he 15 levels of chef attributes and a nodes runlist - a painful
waste of time.  debug\_value can help by telling you roughly at what level 
it's being set at, but it's usefulness stops there.

Enter the chef attribute-debugger. By simply instrumenting an example host in 
question's client.rb file one can find the source of where an attribute is
being set.

#What it is
a series of monkey patches for omnibus chef version 11,16.0 that get applied 
at the client.rb level that can  determine from where an attribute is being 
set. By monkey patchincg all of the points in chef code that injest attributes
 and piggy backing on the existing attribute precedence system.

#what it isn't
a knife plugin, chef handler, etc.

#how to use it
* add the contents of client.rb in this repository to the top of a hosts
[client.rb](client.rb). 
* edit the 'attribut to debug' line at the top to reflect the attribute you 
want to determine the source of. 
* run chef on the host
```
sudo chef-client --once
```
* use knife to show the value of attribute\_debug\_location
```
knife node show HOSTNAME_HERE -a attribute_debug_location
```

#running tests
requirements: docker, kitchen, maybe some kitchen docker plugin, ii forget

```
kitchen test
```
the tests are setup like an onion, where each consecutive test case sets the
test attribute at the next highest level of precedence.

#test status

```
Instance                                         Last Action
1-default-in-attribute-file-ubuntu-1204          Verified
2-default-in-recipe-ubuntu-1204                  Verified
3-environment-default-ubuntu-1204                Verified
4-default-in-role-ubuntu-1204                    Verified
5-force-default-in-attribute-file-ubuntu-1204    Verified
6-force-default-in-recipe-ubuntu-1204            Verified
7-normal-in-attribute-file-ubuntu-1204           Verified
8-normal-in-recipe-ubuntu-1204                   Verified
9-override-in-attribute-file-ubuntu-1204         Verified
10-override-in-recipe-ubuntu-1204                Verified
11-override-in-role-ubuntu-1204                  Verified
12-ovverride-in-environment-ubuntu-1204          Verified
13-force-override-in-attribute-file-ubuntu-1204  Verified
14-force-override-in-recipe-ubuntu-1204          Verified

```
