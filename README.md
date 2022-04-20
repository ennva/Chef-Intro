# Chef-Intrro
Introduction to Chef Configuration Management Platform

## Overview of Chef Architecture
* <b>Workstation</b>: Where you develop,test,versioning you infrastructure as code
* <b>Chef Server</b>: After development, the code can be deploy in the servr according to some Policy, Recipes, Coobooks, etc
* <b>Nodes</b>: The code are then difstribute to any various managed nodes. Node are what run chef code.

## Chef Development Kit (ChefDK - (https://www.chef.io/downloads))
### Workstation Installation
* Chef is build on top of Ruby programming language
* Download ChefDK (https://www.chef.io/downloads/tools/workstation)
* After installing run these commands to check your lab
```
$ chef --version
$ chef-client --version
$ knife --version
$ ohai --version
$ berks --version
$ kitchen --version
$ foodcritic --version
$ cookstyle --version
```
* Consider IDE like Atom or Visual Studio Code or other relevant IDE
* Install CentOS 7.2 Box in workstation. Make sure to have vagrant and virtualbox install on your enviroment and run all these command on Git Bash client:
```
vagrant box add bento/centos-7.2 --provider=virtualbox
```
* Launch the CentOS 7.2 Box
```
vargrant init bento/centos-7.2 (This create a Vagrantfile use to provisioning the machine)
vagrant up (Spin up the VM)
```
* Log In to the CentOS 7.2 box
```
vagrant ssh
```
* Install the chefDk inside the VM
```
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.18.30
```
* Into VM install some of the usefull tools
  - sudo yum install vim -y  or
  - sudo yum install nano -y  or
  - sudo yum install emacs -y
* Create and Open a Recipe (ruby file .rb)
```
file '/hello.txt' do
  content 'Hello, World'
end
```
* Run your Recipe locally and check teh content of file created in / root directory
```
sudo chef-client--local-mode hello.rb
cat /hello.txt
```
* <b>Chef Recipe</b> is filled by a set of Resouce
* <b>Chef Resource</b> is a way to manage a system component. The resource (package, service, File etc..) are idempotent, so is there are present no script(recipe) will gone to be executed 
* <b>Chef Cookbook (containers of Recipe)</b> is a fundamental unit of configuration and policy distribution. When working with server, we distribute a cookbook not eny individual recipe. 
  -  create a directory `mkdir cookbooks`
  -  generate a cookbook using chef command: `chef generate cookbook cookbooks/apache`. Get help `chef generate cookbook --help`
  -  install tree package `sudo yum install tree -y`
  -  generate a new recipe `chef generate recipe cookbooks/apache server`
  -  update the content of the recipe named server.rb in /cookbooks/apache/recipes/server.rb
  -  instead of running a comming on one recipe, run cookbbok commadn `sudo chef-client --local-mode(if not in the server) --runlisst/-r "recipe[COOKBOOK::recipe]"`. This comand will a serie of recipes.
  -  You can include a recipe into another. Ex: include server recide in default one `include_recipe 'apache::server'`
* <b>ohai</b> is a tool that will actually gather host-specific details for you and present them to you in json. It's available when you have chefDK installed. Just run `ohai`
* <b>ohai</b> query the OS with the nu;ber of commands. Everytime you run chef-client command, ohai is executed and store data about the node in an object usable in the recipe
* <b>Chef Template</b> usefull to include content into recipe: `chef generate template [/path/to/cookbook] NAME [options]`

### Chef Server
* <b>knife</v> is a command-line tool that provides an interface between a local chef-repo and the chef Server. With it you can communiate with chef server or your node
* You need to bootstarp your node `knife bootstrap FGDN -x USER -P PWD --sudo -N node1 -r "recipe[cookbook]"`. this will create a chef-client into your node and the client will inform the node about your chef-server
* <b>Kitchen</v> is usefull to test deployments. Configure it to set your test environment unde .kitchen.yml file created when your generate a cookbook
  - commands:
    - kitchen create (create env for testing)
    - kitchen converge (create a desired state)
    - kitchen login (to log in the VM)
    - kitchen verify (lauch the test in test/recipes/default_test.rb of your cookbook)
    - kitchen destroy (destroy your vm)

* <b>Berkshelf</b> is a cookbook management tool that allows you to upload your cookbook and all of its depenedencies to the Chef Server.
  - `berks install`

* <b>Chef Artefacts</b>
  - Roles
  - Environments
  - Data bags

