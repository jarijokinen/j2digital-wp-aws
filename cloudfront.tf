resource "aws_cloudfront_distribution" "wp" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.php"
  price_class         = "PriceClass_All"
  http_version        = "http2and3"

  origin {
    domain_name = aws_lb.wp.dns_name
    origin_id   = "wp"

    custom_header {
      name  = "X-Secret-Header"
      value = var.lb_secret_header
    }

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "wp"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      headers      = ["Host"]
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
