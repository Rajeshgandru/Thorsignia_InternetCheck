
Pod::Spec.new do |spec|


  spec.name         = "Thorsignia_InternetCheck"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of Thorsignia_InternetCheck."


  spec.homepage     = "http://EXAMPLE/Thorsignia_InternetCheck"


  spec.license      = "MIT (example)"


  spec.author             = { "Rajeshgandru" => "rajesh@thorsignnia.net" }
 
  # spec.platform     = :ios, "5.0"

  
  spec.source       = { :git => "http://EXAMPLE/Thorsignia_InternetCheck.git", :tag => "#{spec.version}" }


  
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  
end


Pod::Spec.new do |spec|


spec.name         = "Thorsignia_InternetChecking"
spec.version      = "0.1.2"
spec.summary      = "This the best framework for checking internet."
spec.description  = "The Thorsignia_InternetChecking is leting you that your user internet is in active or inactive."
spec.homepage     = "https://github.com/Rajeshgandru/Thorsignia_InternetChecking"
spec.license      = "MIT"
spec.author             = { "Rajeshgandru" => "rajesh@thorsignnia.net" }
spec.platform     = :ios, "11.0"
spec.source       = { :git => "https://github.com/Rajeshgandru/Thorsignia_InternetChecking.git", :tag => spec.version.to_s }
spec.source_files  = "Thorsignia_InternetChecking/**/*{swift}"
spec.swift_version = "4.0"
end
