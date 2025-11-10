locals {
  all_tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}