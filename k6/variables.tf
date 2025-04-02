
variable "tenancy_ocid" {
    description = "Nacaus 19e tenancy ocid"
}
variable "user_ocid" {
    description = "Lea's user ocid"
}

variable "fingerprint" {
        description = "Lea's fingerprint"
}

variable "private_key_path" {
    description = "path to private key"
    type = string
}

variable "compartment_id" {
    description = "LeaTesting compartment ocid"
}

variable "region" {default = "us-ashburn-1"}

variable "availability_domain" {
    description = "AD"
    type = string
    default = "AD-1"
}

variable "ssh_public_key" {
    description = "SSH Public Key for Instance Access"
    type = string
}


variable "instance_shape" {
    type = string
    default = "VM.Standard.A1.Flex"
}
