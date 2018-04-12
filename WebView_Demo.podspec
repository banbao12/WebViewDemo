Pod::Spec.new do |s|
  s.name         = "WebViewDemo"
  s.version      = "0.0.1"
  s.summary      = "iOS原生hybrid开发示例"
  s.homepage     = "https://github.com/banbao12/WebViewDemo"
  s.license      = "Copyright (C) 2016 banbao12, Inc.  All rights reserved."
  s.author             = { "Gary" => "banbao12@icloud.com" }
  s.social_media_url   = "https://blog.csdn.net/banbaodevelop"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/banbao12/WebViewDemo.git"}
  s.source_files  = "WebView_Demo/UCWebViewController/**/*.{h,m,c}"
  s.requires_arc = true
  s.frameworks = 'UIKit,JavaScriptCore'  
end