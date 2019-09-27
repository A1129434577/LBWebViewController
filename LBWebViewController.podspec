Pod::Spec.new do |spec|
  spec.name         = "LBWebViewController"
  spec.version      = "0.0.1"
  spec.summary      = "带有加载进度条、网页来源的WKWebView。"
  spec.description  = "带有加载进度条、网页来源的WKWebView。"
  spec.homepage     = "https://github.com/A1129434577/LBWebViewController"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBWebViewController.git', :tag => spec.version.to_s }
  spec.source_files = "LBWebViewController/**/*.{h,m}"
  spec.resource     = "LBWebViewController/**/*.png"
  spec.requires_arc = true
end
