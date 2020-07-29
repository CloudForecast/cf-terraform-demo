output "cart_url" {
  value = aws_elb.cart.dns_name
}
output "search_url" {
  value = aws_elb.search.dns_name
}
