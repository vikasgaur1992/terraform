# variables.tf

variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
}

variable "client_id" {
  description = "The client ID of the service principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret of the service principal"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The tenant ID for Azure"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "myResourceGroup"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
  default     = "myWindowsVM"
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
  sensitive   = true
}
