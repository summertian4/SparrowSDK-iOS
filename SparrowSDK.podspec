#
# Be sure to run `pod lib lint SparrowSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SparrowSDK'
  s.version          = '1.4.1'
  s.summary          = 'A Mock Tool'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://git.elenet.me/LPD-iOS/SparrowSDK-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'summertian4' => 'coderfish@163.com' }
  s.source           = { :git => 'git@git.elenet.me:LPD-iOS/SparrowSDK-iOS.git', :tag => 'v' + s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SparrowSDK/Classes/**/*'
  
  s.resource_bundles = {
    'SparrowSDK' => ['SparrowSDK/Assets/*.xcassets']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'SVProgressHUD'
  s.dependency 'SGQRCode'

end
