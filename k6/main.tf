# creation steps: 
# OCI image - optional,
# VCN
# IG 
# RT
# public subnet
# private subnet, skipped
# secuirty list - open ports for grafana and Flask, incoming ssh connections tcp 6, open all egress 
# flask app instance 
# grafana instance

provider "oci" {

        tenancy_ocid = var.tenancy_ocid

        user_ocid = var.user_ocid

        private_key_path = var.private_key_path

        fingerprint = var.fingerprint

        region = var.region
}

# OCI image - may be more useful later 

# create VCN
data "oci_core_vcn" "k6_vcn" {
    #Required
    vcn_id = oci_core_vcn.k6_vcn.id
}

# create internet gateway
resource "oci_core_internet_gateway" "k6_internet_gateway" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.k6_vcn.id

    #Optional
    display_name = "K6 Internet Gateway"
    route_table_id = oci_core_route_table.k6_route_table.id
}

# create route tables
resource "oci_core_route_table" "k6_route_table" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.k6_vcn.id

    #Optional
    display_name = "K6 Route Table"
    route_rules {
        destination = "0.0.0.0/0"
        network_entity_id = oci_core_internet_gateway.k6_internet_gateway.id

    }
}

#create public subnet
resource "oci_core_subnet" "public_subnet" {
    #Required
    cidr_block = "10.0.1.0/24"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.k6_vcn.id
    display_name = "Public Subnet"
    route_table_id = oci_core_route_table.k6_route_table.id
    security_list_ids = [oci_core_security_list.security_list.id]
}

#create security lists
resource "oci_core_security_list" "test_security_list" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.k6_vcn.id
    # allow all outgoing traffic 
    egress_security_rules {
        destination = "0.00.0/0"
        protocol = "all"
        }
    #allow ssh connections port 22
    ingress_security_rules {
        #Required
        protocol = "6"
        source = "0.0.0.0/0"

        tcp_options {
        min = 22
        max = 22
        }
    #open port 5000 to connect to Flask app
    ingress_security_rules {
        #Required
        protocol = "6"
        source = "0.0.0.0/0"

        tcp_options {
        min = 5000
        max = 5000
        }
}


#create flask app instance
resource "oci_core_instance" "flask_instance" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "FlaskAppServer"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux.images[0].id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(<<-EOF
      #!/bin/bash
      # Update and install required packages
      dnf update -y
      dnf install -y python3 python3-pip git

      # Install Flask
      pip3 install flask gunicorn

      # Create a sample Flask app
      mkdir -p /opt/flask-app
      cat > /opt/flask-app/app.py <<'EOL'
      from flask import Flask, jsonify
      import random
      import time

      app = Flask(__name__)

      @app.route('/')
      def hello():
          return jsonify({"message": "Hello World!"})

      @app.route('/metrics')
      def metrics():
          # Generate some random metrics for Grafana to visualize
          cpu = random.uniform(0, 100)
          memory = random.uniform(0, 100)
          return jsonify({
              "cpu_usage": cpu,
              "memory_usage": memory
          })

      if __name__ == '__main__':
          app.run(host='0.0.0.0', port=5000)
      EOL }
}

#create grafana instance

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">=4.67.3"
    }
  }
  required_version = ">= 1.0.0"
}
