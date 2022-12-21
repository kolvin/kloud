include "common" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::https://github.com/kolvin/terraform-aws-route53//?ref=v1.1.0"
}

inputs = {
  route53_zones = [
    {
      name          = "kolv.in"
      type          = "public"
      force_destroy = false
      vpc_id        = ""
      tags          = {}
      dns_records = [
        {
          domain_name = "kolv.in"
          record_type = "A"
          ttl         = 300
          records     = ["76.76.21.21"]
        },
        {
          domain_name = "kolv.in"
          record_type = "MX"
          ttl         = 300
          records     = ["0 kolv-in.mail.protection.outlook.com."]
        },
        {
          domain_name = "kolv.in"
          record_type = "TXT"
          ttl         = 300
          records     = ["NETORGFT11360354.onmicrosoft.com", "v=spf1 include:secureserver.net -all"]
        },
        {
          domain_name = "_sipfederationtls._tcp.@.kolv.in"
          record_type = "SRV"
          ttl         = 300
          records     = ["100 1 5061 sipfed.online.lync.com."]
        },
        {
          domain_name = "_sip._tls.@.kolv.in"
          record_type = "SRV"
          ttl         = 300
          records     = ["100 1 443 sipdir.online.lync.com."]
        },
        {
          domain_name = "_domainconnect.kolv.in"
          record_type = "CNAME"
          ttl         = 300
          records     = ["_domainconnect.gd.domaincontrol.com."]
        },
        {
          domain_name = "autodiscover.kolv.in"
          record_type = "CNAME"
          ttl         = 300
          records     = ["autodiscover.outlook.com."]
        },
        {
          domain_name = "email.kolv.in"
          record_type = "CNAME"
          ttl         = 300
          records     = ["email.secureserver.net."]
        },
        {
          domain_name = "lyncdiscover.kolv.in"
          record_type = "CNAME"
          ttl         = 300
          records     = ["webdir.online.lync.com."]
        },
        {
          domain_name = "msoid.kolv.in"
          record_type = "CNAME"
          ttl         = 300
          records     = ["clientconfig.microsoftonline-p.net."]
        },
        {
          domain_name = "sip.kolv.in"
          record_type = "CNAME"
          ttl         = 300
          records     = ["sipdir.online.lync.com."]
        },
      ]
    }
  ]
}
