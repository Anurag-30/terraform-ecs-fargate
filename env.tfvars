name_prefix = "demo-terraform"
tags = { 
        environment = "dev",
        app= "demo" }
container_definition = "service.json"

subnets = ["subnetid_1","subnetid_2"]

target_group_arn = ""