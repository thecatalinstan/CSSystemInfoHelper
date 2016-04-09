Pod::Spec.new do |s|

  s.name                    =  "CRSystemInfoHelper"
  s.version                 =  "0.1.0"
  s.license                 =  "MIT"

  s.summary                 =  "A utility library for getting system info."

  s.homepage                =  "https://github.com/thecatalinstan/CRSystemInfoHelper"
  s.author                  =   { "Cătălin Stan" => "catalin.stan@me.com" }
  s.social_media_url        =   "http://twitter.com/catalinstan"

  s.source                  =  { :git => "https://github.com/thecatalinstan/CRSystemInfoHelper", :tag => s.version }

  s.module_name             = "CRSystemInfoHelper"

  s.source_files            = "CRSystemInfoHelper/CRSystemInfoHelper.h", "CRSystemInfoHelper/Source/*.{h,m}"
  s.public_header_files     = "CRSystemInfoHelper/CRSystemInfoHelper.h"

  s.ios.deployment_target   = '5.0'
  s.osx.deployment_target   = "10.6"

  s.requires_arc            = true

end