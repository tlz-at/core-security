# Output

output "baseline_version" {
  description = "Version of the baseline module"
  value       = "${module.account-baseline.baseline_version}"
}