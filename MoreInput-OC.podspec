Pod::Spec.new do |spec|
  spec.name         = "MoreInput-OC"
  spec.version      = "0.8.0"
  spec.summary      = "输入框 多选、单选、搜索、手动输入内容."
  spec.description  = <<-DESC
    输入框 多选、单选、搜索、手动输入内容.....
                   DESC
  spec.homepage     = "https://github.com/HenryGaoGH/MoreInput-OC"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "HenryGaoGH" => "yoyohenrygao@163.com" }
  spec.platform     = :ios,"9.0"
  spec.source       = { :git => "https://github.com/HenryGaoGH/MoreInput-OC.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes"
  spec.framework  = "UIKit"

end
