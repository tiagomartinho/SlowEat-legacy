use_frameworks!

target 'SlowEat' do
    platform :ios, '10.0'
    pod 'Sourcery'
    pod 'SnapKit'
    pod 'RealmSwift'
    target 'SlowEatTests' do
        inherit! :search_paths
    end
end

target 'SlowEat WatchKit Extension' do
    platform :watchos, '3.0'
    pod 'RealmSwift'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
