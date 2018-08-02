
Pod::Spec.new do |s|

  s.name         = "NSTimerInprovement"
  s.version      = "0.0.1"
  s.summary      = "NSTimerInprovement：Some functions of NSTimer are improved"
  s.homepage     = "https://github.com/liuchongfaye/NSTimerInprovement"
  s.license      = "MIT"
  s.author       = { "刘冲" => "liuchongfaye@163.com" }
  s.ios.deployment_target = '4.0'
  s.source       = { :git => "https://github.com/liuchongfaye/NSTimerInprovement.git", :tag => "#{s.version}" }
  s.source_files  = "NSTimerInprovement/NSTimer/*.{h,m}"
  s.requires_arc = true

end
