# MARK: - Configuration 

platform :ios, '10.0'
use_frameworks!

# MARK: - Modules

def tools
    pod 'R.swift'
end

def tests
    pod 'SwiftyMocky', '~> 3.5.0'
end

# MArK: - Targets

target 'Workflows' do
    tools
end

target 'WorkflowsTests' do
    inherit! :search_paths
    tests
end

target 'SwiftyWorkflowTests' do
    inherit! :search_paths
    tests
end
