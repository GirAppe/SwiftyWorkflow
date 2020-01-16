# ============= GENERAL ============ #

workspace 'WorkflowTest.xcworkspace'
platform :ios, "10.0"
use_frameworks!
inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

# ============= SCOPES ============= #

def tests
    pod 'SwiftyMocky', '~> 3.5.0'
end

# ============= TARGETS ============ #

target 'WorkflowUnitTests' do
    inherit! :search_paths
    tests
end
