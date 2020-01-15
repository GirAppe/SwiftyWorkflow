Pod::Spec.new do |s|
  s.name             = 'SwiftyWorkflow'
  s.version          = '0.9.0'
  s.summary          = 'Workflows abstraction for Swift. Business oriented declarative way of creating Swift apps.'
  s.description      = <<-DESC
Library that abstracts navigation, to provide business oriented declarative way of creating workflow.
Contains UIKit independent navigation abstraction.
                       DESC

  s.homepage         = 'https://github.com/GirAppe/SwiftyWorkflow'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrzej Michnia' => 'amichnia@gmail.com' }
  s.source           = { :git => 'https://github.com/GirAppe/SwiftyWorkflow.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_versions    = ['5.0', '5.1.2']

  s.default_subspec  = "Core"
  s.preserve_paths = '*'

  s.subspec 'Core' do |core|
      core.source_files = 'SwiftyWorkflow/**/*.swift'
      core.frameworks = 'Foundation'
  end
end
