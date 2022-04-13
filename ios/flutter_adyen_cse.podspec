#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_adyen_cse.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_adyen_cse'
  s.version          = '0.0.1'
  s.summary          = 'Adyen client side encryption library for flutter projects.'
  s.description      = <<-DESC
  Adyen client side encryption library for flutter projects.
                       DESC
  s.homepage         = 'https://github.com/reservamos/flutter-adyen-cse'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'reservamos.com' => 'evaldez@reservamos.mx' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Adyen', '4.7.1'
  s.dependency 'Adyen3DS2', '2.2.4'
  s.platform = :ios, '12.2'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
