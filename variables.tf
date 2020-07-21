#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_preffix" {
  description = "Name preffix for resources on AWS"
}

#------------------------------------------------------------------------------
# AWS Networking
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of the VPC"
}

#------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
variable "internal" {
  description = "(Optional) If true, the LB will be internal."
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "(Optional) A list of security group IDs to assign to the LB."
  type        = list(string)
  default     = []
}

variable "drop_invalid_header_fields" {
  description = "(Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens."
  type        = bool
  default     = false
}

variable "private_subnets" {
  description = "A list of private subnet IDs to attach to the LB if it is INTERNAL."
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnet IDs to attach to the LB if it is NOT internal."
  type        = list(string)
}

variable "idle_timeout" {
  description = "(Optional) The time in seconds that the connection is allowed to be idle. Default: 60."
  type        = number
  default     = 60
}

variable "enable_deletion_protection" {
  description = "(Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "(Optional) Indicates whether HTTP/2 is enabled in the load balancer. Defaults to true."
  type        = bool
  default     = true
}

variable "ip_address_type" {
  description = "(Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. Defaults to ipv4"
  type        = string
  default     = "ipv4"
}

#------------------------------------------------------------------------------
# ACCESS CONTROL TO APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------

variable "enable_http" {
  description = "Enable HTTP Listeners for ports on the variable http_ports. Defaults to true"
  type        = bool
  default     = true
}

variable "http_ports" {
  description = "The list of ports with access to the Load Balancer through HTTP listeners"
  type        = list(number)
  default     = [ 80 ]
}

variable "http_ingress_cidr_blocks" {
  description = "List of CIDR blocks to allowed to access the Load Balancer through HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_ingress_prefix_list_ids" {
  description = "List of prefix list IDs blocks to allowed to access the Load Balancer through HTTP"
  type        = list(string)
  default     = []
}

variable "enable_https" {
  description = "Enable HTTPS Listeners for ports on the variable https_ports. Defaults to true"
  type        = bool
  default     = true
}

variable "https_ports" {
  description = "The list of ports with access to the Load Balancer through HTTPS listeners"
  type        = list(number)
  default     = [ 443 ]
}

variable "https_ingress_cidr_blocks" {
  description = "List of CIDR blocks to allowed to access the Load Balancer through HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "https_ingress_prefix_list_ids" {
  description = "List of prefix list IDs blocks to allowed to access the Load Balancer through HTTPS"
  type        = list(string)
  default     = []
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Target Groups
#------------------------------------------------------------------------------
variable "deregistration_delay" {
  description = "(Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  type        = number
  default     = 300
}

variable "slow_start" {
  description = "(Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds."
  type        = number
  default     = 0
}

variable "load_balancing_algorithm_type" {
  description = "(Optional) Determines how the load balancer selects targets when routing requests. The value is round_robin or least_outstanding_requests. The default is round_robin."
  type        = string
  default     = "round_robin"
}

variable "stickiness" {
  description = "(Optional) A Stickiness block. Provide three fields. type, the type of sticky sessions. The only current possible value is lb_cookie. cookie_duration, the time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds). enabled, boolean to enable / disable stickiness. Default is true."
  type = object({
    type            = string
    cookie_duration = string
    enabled         = bool
  })
  default = {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = true
  }
}

variable "target_group_health_check_enabled" {
  description = "(Optional) Indicates whether health checks are enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "target_group_health_check_interval" {
  description = "(Optional) The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default 30 seconds."
  type        = number
  default     = 30
}

variable "target_group_health_check_path" {
  description = "The destination for the health check request."
  type        = string
  default     = "/"
}

variable "target_group_health_check_timeout" {
  description = "(Optional) The amount of time, in seconds, during which no response means a failed health check. The range is 2 to 120 seconds, and the default is 5 seconds."
  type        = number
  default     = 5
}

variable "target_group_health_check_healthy_threshold" {
  description = "(Optional) The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3."
  type        = number
  default     = 3
}

variable "target_group_health_check_unhealthy_threshold" {
  description = "(Optional) The number of consecutive health check failures required before considering the target unhealthy. Defaults to 3."
  type        = number
  default     = 3
}

variable "target_group_health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, \"200,202\") or a range of values (for example, \"200-299\"). Default is 200."
  type        = string
  default     = "200"
}

variable "https_cert_arn" {
  description = "HTTPS cert arn"
  type        = string
  default     = ""
}
