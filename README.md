This is a terraform project to create resources in AWS. You can use this code to create an autoscaling group consisting of 2 servers, 
that are behind an application load balancer. A VPC is created with 3 public subnets (where ALB resides) and 3 private subnets (where the
ASG resides). A bastion/vpn server is also created using OpenVPN. This templates assume that you have already created a key that will be 
pulled from ~/.ssh/ directory.

You can also customize the following variables in the modules file:

Networking variables
    vpc_cidr 
    tenancy 
    private0_cidr 
    private1_cidr 
    private2_cidr 
    public0_cidr 
    public1_cidr 
    public2_cidr
#VPN user to create
    ovpn_user 
#Instance type for VPN
    instance_type 
#Instance type for web
    instance_type_web 

