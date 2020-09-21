module "vpc" {
    source = "./modules/vpc"
#networking variables which you can customize:
    vpc_cidr = "172.20.0.0/16"
    tenancy = "default"
    private0_cidr = "172.20.0.0/24"
    private1_cidr = "172.20.1.0/24"
    private2_cidr = "172.20.2.0/24"
    public0_cidr = "172.20.3.0/24"
    public1_cidr = "172.20.4.0/24"
    public2_cidr = "172.20.5.0/24"
}
module "ec2" {
    source = "./modules/ec2"
    #computing variables
    pub_key = file("~/.ssh/id_rsa.pub")
    sg-ag = "${module.vpc.sg-ag}"
    sg-alb = "${module.vpc.sg-alb}"
    sg-bastion = "${module.vpc.sg-bastion}"
    private0 = "${module.vpc.private0}"
    private1 = "${module.vpc.private1}"
    private2 = "${module.vpc.private2}"
    public0 = "${module.vpc.public0}"
    public1 = "${module.vpc.public1}"
    public2 = "${module.vpc.public2}"
    vpc_id = "${module.vpc.current_vpc}"
    userdata = file("${path.module}/scripts/install_httpd.sh")
    vpn_eip = "${module.vpc.vpn_eip}"
    eip_ip4 = "${module.vpc.eip_ip4}"
    # you can customize username for vpn and instance size for workloads
    ovpn_user = "lelwar2"
    instance_type = "t2.small"
    instance_type_web = "t3.small"
}


