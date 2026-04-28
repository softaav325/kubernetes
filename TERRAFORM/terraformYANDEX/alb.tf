//
// Create a new Application Load Balancer (ALB)
//
# resource "yandex_alb_load_balancer" "alb_jti" {
#   name = "load-balancer-jti"

#   network_id = yandex_vpc_network.vpc-k8s.id

#   allocation_policy {
#     location {
#       zone_id   = local.zone
#       subnet_id = yandex_vpc_subnet.subnet-k8s.id
#     }
#   }

#   listener {
#     name = "listener"
#     endpoint {
#       address {
#         external_ipv4_address {
#         }
#       }
#       ports = [8080]
#     }
#     http {
#       handler {
#         http_router_id = yandex_alb_http_router.test-router.id
#       }
#     }
#   }

#   log_options {
#     discard_rule {
#       http_code_intervals = ["2XX"]
#       discard_percent     = 75
#     }
#   }
# }
