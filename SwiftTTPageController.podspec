  Pod::Spec.new do |s|
  s.name         = "SwiftTTPageController"
  s.version      = "0.0.1"
  s.summary      = "仿今日头条首页、网易新闻首页 ，实现多个ViewController列表切换."
  s.description  = <<-DESC
  A Simple PageController Like Toutiao 、NetEase Home(仿今日头条首页、网易新闻首页 ，实现多个ViewController列表切换).
                   DESC

  s.homepage     = "https://github.com/Light413/SwiftTTPageController"
  s.license = "MIT"
  s.author  = { "Light413" => "18016373660@163.com" }

  s.platform     = :ios, "9.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/Light413/SwiftTTPageController.git", :tag => s.version }

  s.source_files  = "SwiftTTPageController/SwiftTTPageController/*.{swift}"
  s.requires_arc = true

end
