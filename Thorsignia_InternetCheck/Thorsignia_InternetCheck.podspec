
Pod::Spec.new do |spec|

  spec.name         = "Thorsignia_InternetCheck"
  spec.version      = "0.1.0"
  spec.summary      = "This the best framework for checking internet."
  spec.description  = "The Thorsignia_InternetChecking is leting you that your user internet is in active or inactive."

  spec.homepage     = "https://github.com/Rajeshgandru/Thorsignia_InternetCheck"
  spec.license      = "MIT"
  spec.author       = { "Rajeshgandru" => "rajesh@thorsignnia.net" }
 
  spec.platform   = :ios, "14.4"
  spec.source       = { :git => "https://github.com/Rajeshgandru/Thorsignia_InternetCheck.git", :tag => spec.version.to_s }
 
  spec.source_files  = "Thorsignia_InternetCheck/**/*{swift}"
  spec.swift_version = "5.0"

end


