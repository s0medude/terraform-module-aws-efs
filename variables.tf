variable "create_efs" {
    description = "Controls if a EFS Resource should be created"
    type        = bool
    default     = true  
}

variable "name" {
    description = "The name that will be used in all the resources"
    type        = string
    default     = ""
}

variable "efs_suffix" {
    description = "The sufix string that wll be used in the EFS resource"  
    type        = string
    default     = ""
}


variable "azs" {
    description = "The azs of the subnets to mount the EFS"
    type        = number
    default     = null
}

variable "creation_token" {
    description = "A unique name (a maximum of 64 characters are allowed) used as reference when creating the Elastic File System to ensure idempotent file system creation"
    type        = string
    default     = ""
}

variable "performance_mode" {
    description = "The file system performance mode. Can be either 'generalPurpose' or 'maxIO' (Default: 'generalPurpose')"
    type        = string
    default     = "generalPurpose"      
}

variable "throughput_mode" {
    description = "Throughput mode for the file system. Defaults to bursting. Valid values: bursting, provisioned. When using provisioned, also set provisioned_throughput_in_mibps."
    type        = string
    default     = "bursting"  
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
    default     = ""  
}

variable "vpc_cidr_block" {
    description = "The CIDR Block of the VPC"
    type        = string
    default     = ""  
}

variable "private_subnets" {
    description = "The list of subnets where the EFS will be mounted"
    type        = list(string)
    default     = []  
}

variable "private_subnets_cidr" {
    description = "The list of the Subnets CIDR blocks where to mount the EFS resource"
    type        = list(string)
    default     = []
}

variable "description" {
    description = "If you want you can add a description to identify the purpose of it"
    type        = string
    default     = "Security group for the EFS resource than can be access through the private subnets only"  
}

variable "tags" {
    description = "A map of tags to add to all resources in this module"
    type        = map(string)
    default     = {}
}

variable "efs_tags" {
    description = "A map of tags to add to EFS resources"
    type        = map(string)
    default     = {}
}

variable "rules" {
    description = "The map of list of the rules assigned to the securitu group that can access the EFS resource"
    type        = map(list(any)) 
    default     = {
        nfs-2049-tcp = [2049, 2049, "tcp", "NFS/EFS"]
    }
}

variable "security_group_ingress_rules" {
    description = "The name of the security group rule map must be provided here"
    type        = list(string)
    default     = ["nfs-2049-tcp"] 
}

variable "security_group_tags" {
    description = "A map of tags to add to Security Group for EFS"
    type        = map(string)
    default     = {}  
}


