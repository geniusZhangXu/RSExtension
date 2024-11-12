#
# Be sure to run `pod lib lint RSExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RSExtension'
  # 版本设置
  s.version          = '0.0.7'
  s.summary          = '自定义各种类型的Extension文件'
  # 兼容的Swift版本
  s.swift_versions   = '5.0'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  # 你的主页地址 填个能访问的 不然可能检验的时候报错
  s.homepage         = 'https://github.com/geniusZhangXu/RSExtension'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  # 作者
  s.author           = { 'Mr.RisingSun' => '13535471825@163.com' }
  # 你制作私有库项目的远程地址
  s.source           = { :git => 'https://github.com/geniusZhangXu/RSExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # 兼容最低系统版本
  s.ios.deployment_target = '13.0'

  s.source_files = 'RSExtension/Classes/**/*'
  # s.resource_bundles = {
  #   'RSExtension' => ['RSExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # 依赖的第三方的库
  # HUD
  s.dependency 'MJRefresh'
  s.dependency 'Kingfisher'
  # 展示Toast
  s.dependency 'Toast-Swift'
  # 进度HUD
  s.dependency 'ProgressHUD'
  
end
