Pod::Spec.new do |s|
  s.name         = "SwiftTTPageController"
  s.version      = "0.0.5"
  s.summary      = "A useful PageController lib 仿今日头条首页、网易新闻首页 ，实现多个ViewController列表切换."
  s.description  = <<-DESC
                    A Simple PageController ,like Toutiao , NetEase Home.(仿今日头条首页、网易新闻首页 ，实现多个ViewController列表切换).
                     DESC

  s.homepage     = "https://github.com/Light413/SwiftTTPageController"
  s.license = "MIT"
  s.author  = { "Light413" => "1289988413@qq.com" }

  #s.platform     = :ios, "9.0"
  s.ios.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/Light413/SwiftTTPageController.git", :tag =>s.version }

  s.source_files  = "SwiftTTPageController/SwiftTTPageController/*.swift"
  s.requires_arc = true
  s.framework    = "UIKit","Foundation"
end
