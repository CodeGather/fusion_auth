#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fusion_auth.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fusion_auth'
  s.version          = '1.0.4'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
  是一个集成阿里云号码认证融合服务SDK的flutter插件
                       DESC
  s.homepage         = 'https://github.com/CodeGather/fusion_auth'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'raohong07@163.com' }
  s.source           = { :path => '.' }

  s.platform = :ios, '12.0'

  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency 'Flutter'
  s.dependency 'MJExtension'
  s.dependency 'MBProgressHUD'

  s.vendored_frameworks = 'frameworks/*.framework'
  s.resource = 'frameworks/ATAuthSDK.framework/ATAuthSDK.bundle'
  s.framework = 'Network'
  s.static_framework = false

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
