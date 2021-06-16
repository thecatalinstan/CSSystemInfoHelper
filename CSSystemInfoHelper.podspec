Pod::Spec.new do |s|

  s.name                        =  "CSSystemInfoHelper"
  s.version                     =  "1.4.2"
  s.license                     =  "MIT"

  s.summary                     =  "A utility library for getting system info."

  s.homepage                    =  "https://github.com/thecatalinstan/CSSystemInfoHelper"
  s.author                      =   { "Cătălin Stan" => "catalin.stan@me.com" }
  s.social_media_url            =   "http://twitter.com/catalinstan"

  s.source                      =  { :git => "https://github.com/thecatalinstan/CSSystemInfoHelper.git", :tag => s.version }

  s.module_name                 = "CSSystemInfoHelper"

  s.source_files                = "CSSystemInfoHelper/Sources/*.{h,m}"
  s.public_header_files         = "CSSystemInfoHelper/Headers/CSSystemInfoHelper/CSSystemInfoHelper.h"

  s.ios.deployment_target       = "9.0"
  s.ios.frameworks              = "Foundation"

  s.osx.deployment_target       = "10.9"
  s.osx.frameworks              = "Foundation"

  s.tvos.deployment_target      = "9.0"
  s.tvos.frameworks             = "Foundation"

  s.watchos.deployment_target   = "2.0"
  s.watchos.frameworks          = "Foundation"

  s.requires_arc                = true

end
