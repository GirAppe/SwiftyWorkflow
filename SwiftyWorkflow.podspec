#
# Be sure to run `pod lib lint Mocky.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyWorkflow'
  s.version          = '0.2.1'
  s.summary          = 'Workflows abstraction for Swift. Business oriented declarative way of creating Swift apps.'
  s.description      = <<-DESC
Library that abstracts navigation, to provide business oriented declarative way of creating views flow.
Handles dependency injection containers and UIKit independent navigation abstraction.
                       DESC

  s.homepage         = 'https://github.com/GirAppe/SwiftyWorkflow'
  # s.screenshots      = 'https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/icon.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrzej Michnia' => 'amichnia@gmail.com' }
  s.source           = { :git => 'https://github.com/GirAppe/SwiftyWorkflow.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.default_subspec  = "Core"
  s.preserve_paths = '*'

  s.subspec 'Core' do |core|
      core.source_files = 'SwiftyWorkflow/{Categories,Workflow,Injection,Routing}/*'
      core.frameworks = 'Foundation'
  end
end
