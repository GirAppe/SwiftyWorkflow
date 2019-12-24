## [ CocoaPods ] ###############################################################

desc "Install project dependencies"
desc "In case of need, pod repo update will be invoked"
task :pods do
    begin
        print_info "Installing dependencies from CocoaPods"
        sh "pod install"
    rescue
        print_info "Install failed - trying repo update"
        sh "pod repo update"
        sh "pod install"
    end
end

## [ Xcode ] ##################################################################

desc "Open the workspace in Xcode"
task :xcode do
    workspace = "./Workflows.xcworkspace"
    sh "open #{workspace}"
end

## [ Tools ] ###################################################################

desc "Install tools"
task :tools do
    begin
        print_info "Installing tools dependencies with Mint"
        sh "mint bootstrap"
    rescue
        print_info "Failed - check if Mint installed"
    end
end

desc "Setup test app environments"
task :environment do
    begin
        print_info "Runnin AutoEnvironment"
        sh "mint run autoenvironment autoenvironment -p Workflows.xcodeproj/ -o ./Workflows"
    rescue
        print_info "Failed - check if Mint installed"
    end
end

## [ Deploy ] ##################################################################

desc "Deploys new version of a binary, by pushing passed tag"
task :deploy do
    ARGV.each { |a| task a.to_sym do ; end }
    version = ARGV[1].to_s
    if version
        sh("sed 's|{{VERSION_NUMBER}}|#{version}|g' ./Podspec.template > ./SwiftyWorkflow.podspec")
        sh("git add *")
        sh("git commit -m \"Deploy #{version}\"")
        sh("git push")
        sh("git tag #{version} && git push --tags")
        sh("pod trunk push")
    end
end

## [ Mocks Generation ] ########################################################

desc "Regenerates mocks"
task :mock do
    sh "mint run swiftymocky swiftymocky generate"
end

desc "Regenerates mocks with clearing cache"
task :mock_regen do
    sh "mint run swiftymocky swiftymocky generate --disableCache"
end

## [ Helpers ] #################################################################

desc "Purge Derived data"
task :purge do
    sh("rm -rf ~/Library/Developer/Xcode/DerivedData/*")
end

def print_info(str)
    (red,clr) = (`tput colors`.chomp.to_i >= 8) ? %W(\e[33m \e[m) : ["", ""]
    puts red, "== #{str.chomp} ==", clr
end
