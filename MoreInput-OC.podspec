#
# Be sure to run `pod lib lint MoreInput-OC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MoreInput-OC'
  s.version          = '0.8.0'
  s.summary          = '可输入、可选择、可单项、可多项的表单组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
这是一个很Nice的表填输入器.支持的功能:
- 单项输入
- 单项选择
- 多项输入
- 多项选择
- 删除已选
- 高亮显示已选
- 删除已选
- .....
                       DESC

  s.homepage         = 'https://github.com/HenryGaoGH/MoreInput-OC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henry Gao' => 'YoYoHenryGao@163.com' }
  s.source           = { :git => 'https://github.com/HenryGaoGH/MoreInput-OC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = "Classes", "MoreInput-OC/Classes/**/*.{h,m}"
  
  # s.resource_bundles = {
  #   'MoreInput-OC' => ['MoreInput-OC/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'#, 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
