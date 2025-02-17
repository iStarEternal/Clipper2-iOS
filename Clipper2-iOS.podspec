#
# Be sure to run `pod lib lint Clipper2-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Clipper2-iOS'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Clipper2-iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hyh/Clipper2-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hyh' => '576681253@qq.com' }
  s.source           = { :git => 'https://github.com/hyh/Clipper2-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.public_header_files = 'Classes/**/*.h'

  s.source_files = [
    'Clipper2-iOS/Classes/**/*',
    'Clipper2-iOS/Libs/Clipper2Lib/**/*',
    'Clipper2-iOS/Tmp/**/*'
  ]
  s.private_header_files = [
    'Clipper2-iOS/Libs/Clipper2Lib/**/*.h'
  ]
  #  s.header_mappings_dir = "LPAlgorithm/Libs/Clipper2Lib/include/clipper2"
  s.compiler_flags = '-std=c++17'
  # s.libraries = 'z', 'stdc++'
  # s.requires_arc     = false

  # s.resource_bundles = {
  #   'Clipper2-iOS' => ['Clipper2-iOS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
#    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'OTHER_LDFLAGS' => '$(inherited) -ObjC'
  }
end
