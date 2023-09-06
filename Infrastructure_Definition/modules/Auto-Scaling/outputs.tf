# Instance IDs
output "instanceIds" {
  value = join(",", data.aws_instances.nodeInstance.*.id)
}