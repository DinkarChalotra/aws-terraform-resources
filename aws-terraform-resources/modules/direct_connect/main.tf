resource "aws_dx_connection" "example_connection" {
  name              = var.name
  bandwidth         = var.bandwidth
  location          = var.location
  provider_name     = var.provider_name
  amazon_address    = var.amazon_address
  customer_address  = var.customer_address
  bgp_asn           = var.bgp_asn
  vlan              = var.vlan
  jumbo_frame_capable = var.jumbo_frame_capable
}

variable "name" {
  type        = string
  description = "The name of the Direct Connect connection to create."
}

variable "bandwidth" {
  type        = string
  description = "The bandwidth of the connection in Gbps."
}

variable "location" {
  type        = string
  description = "The location of the Direct Connect connection."
}

variable "provider_name" {
  type        = string
  description = "The name of the Direct Connect service provider."
}

variable "amazon_address" {
  type        = string
  description = "The Amazon address for the connection."
}

variable "customer_address" {
  type        = string
  description = "The customer address for the connection."
}

variable "bgp_asn" {
  type        = string
  description = "The BGP ASN for the connection."
}

variable "vlan" {
  type        = number
  description = "The VLAN ID for the connection."
}

variable "jumbo_frame_capable" {
  type        = bool
  description = "Whether the connection is capable of jumbo frames (9001 MTU)."
}
