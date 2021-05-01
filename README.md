# test-appgate
![](images/AWS_logo_PMS_300x180.png)

![](images/100x100_benefit_available.png)![](images/100x100_benefit_ingergration.png)![](images/100x100_benefit_ecryption-lock.png)![](images/100x100_benefit_fully-managed.png)![](images/100x100_benefit_lowcost-affordable.png)![](images/100x100_benefit_performance.png)![](images/100x100_benefit_scalable.png)![](images/100x100_benefit_storage.png)

Esta proyecto proporciona un conjunto de plantillas YAML para implementar una pagina web en AWS utilizando Amazon Virtual Private Cloud (Amazon VPC) , Amazon Elastic Compute Cloud (Amazon EC2) , Elastic Load Balancing (Application Load Balancer) con AWS CloudFormation.

El repositorio consta de un conjunto de plantillas que se ejecutan en un orden, ingresando los parámetros apropiados para cada pila.

## Orden de despliegue de las plantillas

1. template-newvpc-v2.yaml

Esta plantilla Crea una VPC con el siguiente segmento de red: 10.1.96.0/24. y a su vez crea 5 subredes en diferentes AZ cada una; 3 son privadas y las otras 2 públicas.

2. template-ec2-v2.yaml

Esta plantilla Crea 2 instancias EC2 t3.micro con una AMI de Centos 7. adicional cada instancia se monta un disco con 10 GB Gp2 como una partición añadida a la ruta "/data_test"; como servicio se Implemento un servidor web Apache los EC2 creados utilizando docker-compose.

Se creo un script sh que recopile el total de las conexiones abiertas en el servidor web Apache implementado, para cada hora del día en curso. los archivos de registro de Apache.

3. template-publicalb-v2.yaml

Esta plantilla crea un balanceador de carga de aplicaciones AWS como el único punto de entrada para sus solicitudes en la página web. Este componente balancea las solicitudes entrantes entre los dos EC2.

El balanceador de carga sólo responde a la solicitud de páginas web a través del puerto 80 con HTTP.


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

## Amazon Virtual Private Cloud (Amazon VPC) Template
Revise la plantilla aquí  [template-newvpc-v2.yaml](templates/template-newvpc-v2.yaml)

## Amazon Elastic Compute Cloud (Amazon EC2) Template
Revise la plantilla aquí  [template-ec2-v2.yaml](templates/template-ec2-v2.yaml)

## Amazon Elastic Load Balancing - Application Load Balancer Template
Revise la plantilla aquí  [aws-refarch-wordpress-03-publicelb.yaml](templates/template-publicalb-v2.yaml)