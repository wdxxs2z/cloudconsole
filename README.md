# cloudconsole
This is cloudfoundry console <br />
### cloudconfig.properties
1.Target cloudfoundry api url to 'domain' <br />
2.Target cloudfoundry sub_domain url such as 127.0.0.1.xip.io <br />
3.Write your nats_servers <br />
4.OAuth_proxy is your admin and password to register. <br />
### cloudfoundry web console
1.Find the home <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_home.jpg) <br />
2.Some cloud platform events <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_event.jpg) <br />
3.Organization summary <br>
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_organization.jpg) <br />
4.Space summary <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_spaces.jpg) <br />
5.CloudFoundry security groups view and edit <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_security.jpg) <br />
6.CloudFoundry App upload and app stats realtime <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_uploadapp.jpg) <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_appstats.jpg) <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_appurls.jpg) <br />
7.Services <br />
![Peter don't care](https://github.com/wdxxs2z/PictureStore/blob/master/cloudconsole/cloudconsole_services.jpg) <br />
8.Monit components <br />
Add 2 ways 1.gnatsd. 2.monit server. < br />
### cloudconsole admin token (token.sh)
    #!/bin/bash
    uaac target --skip-ssl-validation https://uaa.192.168.172.128.xip.io
    uaac token client get admin -s c1oudc0w
    uaac contexts
    uaac client update admin --authorities "password.write clients.write clients.read scim.read uaa.admin clients.secret scim.write"
    uaac token delete
    uaac token client get admin -s c1oudc0w
    #uaac member add cloud_controller.admin uuu
    uaac group reader add cloud_controller.admin admin
    uaac group writer add cloud_controller.admin admin
    #uaac group writer add scim.read admin
    uaac group writer add scim.write admin
    uaac group reader add scim.read admin
