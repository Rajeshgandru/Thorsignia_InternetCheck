# Thorsignia_InternetCheck
 
The Thorsignia_InternetChecking is leting you that your user internet is in active or inactive.  


### Requirements
iOS 11.0+ 

Supported devices : 
* iPhone 
* iPad 
 

### How to get started
  - Install our library on your project (see below).
  - Import our pod to your main class.
  - Intialise given methods into that class.

### Integration
Find the integration information by following [this link]

### Installation with CocoaPods

CocoaPods is a dependency manager which automates and simplifies the process of using 3rd-party libraries in your projects.

### Podfile

  - iOS application : 

```ruby
target 'MyProject' do
pod "Thorsignia_InternetCheck"
use_frameworks!
end
```





## Integration samples
### Tracker
```swift
// Your initial class.swift
import Thorsignia_InternetCheck

//calling method in viewdidload
override func viewDidLoad() {
    super.viewDidLoad()
    //intialising internet checking...
    self.CheckingInterNet()
 }
 
 //Internet check main method...
func CheckingInterNet(){
    var timer = Timer()
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
}
//With timer support handling internet handling...
@objc func updateCounting(){
    NSLog("counting..")
     if  R_InternetClassValidator.InternetChecking() {
        print(" 👊👊👊👊👊👊 your internet is working fine...👊👊👊👊👊")
       // self.showAlert(msg : " Dam your internet is working fine bro...")
    }else {
        print(" 👊👊👊👊👊your internet have some issue, please check...👊👊👊👊")
        //self.showAlert(msg : " Dam your internet have some issue, please check bro...")

    }
}
```

### License
MIT

   [documentation page]: <https://developers.atinternet-solutions.com/apple-universal-en/getting-started-apple-universal-en/integration-of-the-swift-library-apple-universal-en/>
   [here]: <https://developers.atinternet-solutions.com/apple-universal-fr/contenus-de-lapplication-apple-universal-fr/rich-media-apple-universal-fr/#refresh-dynamique-2-9_3/>

