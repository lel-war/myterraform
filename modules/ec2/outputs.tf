output "web-service-url" {
    value = "${aws_lb.web.dns_name}"
}