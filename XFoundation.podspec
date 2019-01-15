#
#  Be sure to run `pod spec lint XFoundation.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "XFoundation"
  s.version      = "0.0.1"
  s.summary      = "XF.....迅速的开发简单的应用,迅速的开发简单的应用,迅速的开发简单的应用"

  s.description  = <<-DESC
                    迅速的开发简单的应用,迅速的开发简单的应用,迅速的开发简单的应用
                   DESC

  s.homepage     = "https://github.com/xxdzyyh/XFoundation"
  s.license      = "MIT (xxdzyyh)"

  s.author             = { "xxdzyyh" => "591392966@qq.com" }
  # Or just: s.author    = "xxdzyyh"
  # s.authors            = { "xxdzyyh" => "email@address.com" }
  # s.social_media_url   = "http://twitter.com/xxdzyyh"

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/xxdzyyh/XFoundation.git", :branch => "master" }

  s.public_header_files = 'XFoundation/Header/*.h'

  s.subspec 'Base' do |spec| 
    spec.source_files = 'XFoundation/Base/*'
  end

  s.subspec 'Request' do |spec|
    spec.source_files = 'XFoundation/Request/**/*'
  end

  s.subspec 'View' do |spec| 
    spec.source_files = 'XFoundation/View/*'
  end

  s.subspec 'App' do |spec| 
    spec.source_files = 'XFoundation/App/*'
  end

  s.dependency 'MJRefresh'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

end
