Pod::Spec.new do |s|

  s.name         = "ACSFramework"
  s.version      = "0.0.8"
  s.summary      = "iOS 基本框架"
  s.description  = <<-DESC
                    iOS 基本框架，添加了一些常用的第三方库，并且使用pods管理；对UIView进行拓展（ACSUIKit），添加一些常用的工具（ACSTool）
                   DESC

  s.homepage     = "https://github.com/qigge/ACSFramework"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Eric" => "wangzeqi2013@foxmail.com" }

  s.platform     = :ios
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/qigge/ACSFramework.git", :tag => "#{s.version}" }

  s.frameworks = "UIKit"
  s.requires_arc = true

    s.subspec 'UIKit' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/**/*"
    end 

    s.subspec 'KeyboardCorver' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSKeyboardCorver/"
    end

    s.subspec 'EmptyDataset' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSEmpty/"
    end

    s.subspec 'ACSTextView' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSTextView/"
    end

    s.subspec 'ACSFont' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSFont/"
    end

    s.subspec 'ACSTapsView' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSTapsView/"
    end

    s.subspec 'ACSTextField' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSTextField/"
    end

    s.subspec 'ACSView' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSView/"
    end

    s.subspec 'ACSColor' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSColor/"
    end

    s.subspec 'ACSLabel' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSLabel/"
    end

    s.subspec 'ACSButton' do |sp|
        sp.source_files  = "ACSFramework/Lib/ACSUIKit/ACSButton/"
    end
end
