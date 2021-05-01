# test-appgate
![](images/AWS_logo_PMS_300x180.png)

![](images/100x100_benefit_available.png)![](images/100x100_benefit_ingergration.png)![](images/100x100_benefit_ecryption-lock.png)![](images/100x100_benefit_fully-managed.png)![](images/100x100_benefit_lowcost-affordable.png)![](images/100x100_benefit_performance.png)![](images/100x100_benefit_scalable.png)![](images/100x100_benefit_storage.png)

Esta proyecto proporciona un conjunto de plantillas YAML para implementar una pagina web en AWS utilizando Amazon Virtual Private Cloud (Amazon VPC) , Amazon Elastic Compute Cloud (Amazon EC2) , Elastic Load Balancing (Application Load Balancer) con AWS CloudFormation.

El repositorio consta de un conjunto de plantillas que se ejecutan en un orden, ingresando los parámetros apropiados para cada pila.

## Orden de despliegue de las plantillas

1. template-newvpc-v2.yaml
2. template-ec2-v2.yaml
3. template-publicalb-v2.yaml


## Steps to Run

haga clic en uno de los enlaces Launch Stack a continuación o descargue el proyecto y ejecutelo en el orden mencionado.

Puede lanzar estas plantillas utilizando CloudFormation, con su cuenta, en las siguientes regiones de AWS:

| AWS Region Code | Name | Launch |
| --- | --- | --- 
| us-east-1 |US East (N. Virginia)| [![cloudformation-launch-stack](images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=WordPress&templateURL=https://s3.amazonaws.com/aws-refarch/wordpress/latest/templates/aws-refarch-wordpress-master-newvpc.yaml) |
| us-east-2 |US East (Ohio)| [![cloudformation-launch-stack](images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/new?stackName=WordPress&templateURL=https://s3.amazonaws.com/aws-refarch/wordpress/latest/templates/aws-refarch-wordpress-master-newvpc.yaml) |
| us-west-2 |US West (Oregon)| [![cloudformation-launch-stack](images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=WordPress&templateURL=https://s3.amazonaws.com/aws-refarch/wordpress/latest/templates/aws-refarch-wordpress-master-newvpc.yaml) |
| eu-west-1 |EU (Ireland)| [![cloudformation-launch-stack](images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/new?stackName=WordPress&templateURL=https://s3.amazonaws.com/aws-refarch/wordpress/latest/templates/aws-refarch-wordpress-master-newvpc.yaml) |
| eu-central-1 |EU (Frankfurt)| [![cloudformation-launch-stack](images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/new?stackName=WordPress&templateURL=https://s3.amazonaws.com/aws-refarch/wordpress/latest/templates/aws-refarch-wordpress-master-newvpc.yaml) |
| ap-southeast-2 |AP (Sydney)| [![cloudformation-launch-stack](images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-2#/stacks/new?stackName=WordPress&templateURL=https://s3.amazonaws.com/aws-refarch/wordpress/latest/templates/aws-refarch-wordpress-master-newvpc.yaml) |

#### Stack Creation

There are two output URLs for the master template. The WPSiteURL will take you to your new WordPress site. It will be the site domain name if you provided one, the CloudFront URL if you chose to create a CloudFront distribution, or the domain name of the public application load balancer.  The second output URL will take you to the OpCache Status page for each EC2 instance in the AutoScaling group. By refreshing the page you will be able to verify OpCache has been enabled on each instance.

#### OPcache

OPcache is a byte-code cache engine running on each EC2 instance that caches precompiled PHP scripts that boosts performance of PHP applications like WordPress. It is recommended to use a caching engine like OpCache when serving PHP pages for a website from Amazon EFS.  OPcache can be configured to store it's cache in memory or on EBS volumes.

##### Recommended OPcache Configuration Settings

- Mount the EFS file system using the default Linux mount options identified in the [Amazon EFS User Guide](http://docs.aws.amazon.com/efs/latest/ug/mounting-fs-mount-cmd-general.html).
Changing some of the activating caching options from their defaults, like actimeo, acregmax, or acdirmax may generate significantly higher metadata operations by timing out the attribute caches more frequently. Careful testing is recommended if the defaults are not used.
 
- Increase the size of realpath_cache_size. Setting it to 512k is a good start but finding out how much realpath cache you’re actually using will help you fine tune this setting and be more precise. To find out how much real path cache you’re actually using, place the following php code snippet in a php file (you can use any name – for example realpathcache.php) and place it in your WordPress directory. Open a browser and point to this php file.  Refresh your page multiple times. The value being returned is the amount of memory in bytes realpath cache is using. Take note of the maximum value being returned after refreshing this page multiple times.  This, plus a little headroom, should be the value of the realpath_cache_size setting.
```
<?php
 print_r(realpath_cache_size());
?>
```
 
- Please get the number of php files using “find . -type f -print | grep php | wc -l” in your WordPress directory. This number should be smaller than your opcache.max_accelerated_files settings. This setting controls how many PHP files, at most, can be held in memory at once. It's important that your project has LESS FILES than whatever you set this at.

- The default value for opcache.memory consumption is 64 MB. Increasing this setting could improve performance by caching more files in memory. Consider setting this to a value of 512MB (opcache.memory_consumption=512) or more to improve performance. Testing different opcache.memory consumption values is recommended to optimize the performance for your particular workload. In case memory size turns out to be a limiting factor, the cloudformation template also configures opcache.file_cache to use local storage (an EBS or instance store volume). During testing we recommend disabling opcache.validate_timestamps so calls are not being made to the NFS server to ensure opcache’s coherency. It is not recommended that opcache.validate_timestamps be disabled in production.

To learn more about OPcache, please read http://php.net/manual/en/book.opcache.php

