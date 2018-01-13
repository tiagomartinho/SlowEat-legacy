platform :ios, '10'
use_frameworks!

target 'SlowEat' do

    pod 'Instabug'
    pod 'Mixpanel'
    pod 'Sourcery'
    pod 'SnapKit'

    target 'SlowEatTests' do
        inherit! :search_paths
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
            if config.name == 'Release'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
                else
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
            end
        end
    end
end
