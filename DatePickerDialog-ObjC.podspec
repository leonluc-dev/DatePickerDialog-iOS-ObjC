Pod::Spec.new do |s|
  s.name         = "DatePickerDialog-ObjC"
  s.version      = "1.2"
  s.summary      = "Date picker dialog for iOS"
  s.homepage     = "https://github.com/leonluc-dev/DatePickerDialog-iOS-ObjC"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Leon Lucardie" => "leonlucardie@gmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = "12.0"
  s.source       = { :git => "https://github.com/leonluc-dev/DatePickerDialog-iOS-ObjC.git", :tag => s.version }
  s.source_files  = "Sources/LSLDatePickerDialog.{h,m}"
  s.requires_arc = true
end

