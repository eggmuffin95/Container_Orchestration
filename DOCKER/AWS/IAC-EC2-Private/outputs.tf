output "DTRDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${aws_elb.dtr-elb.dns_name}"
}

output "AppDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${aws_elb.apps-elb.dns_name}"
}

output "UCPDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${aws_elb.ucp-elb.dns_name}"
}
