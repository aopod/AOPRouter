#
# Be sure to run `pod lib lint AOPRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AOPRouter'
  s.version          = '1.0.0'
  s.summary          = 'A URL routing solution for iOS'
  s.description      = <<-DESC
A URL routing solution for iOS. With features such as autocomplete, comment, duplication check, miss handler, etc.
                       DESC

  s.homepage         = 'https://github.com/aopod/AOPRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aopod' => 'aopodcom@gmail.com' }
  s.source           = { :git => 'https://github.com/aopod/AOPRouter.git', :tag => s.version.to_s }
  s.social_media_url = 'http://www.aopod.com'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AOPRouter/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
