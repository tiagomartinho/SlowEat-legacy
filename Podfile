target 'SlowEat' do
  use_frameworks!

  pod 'Instabug'
  pod 'Mixpanel'

  target 'SlowEatTests' do
    inherit! :search_paths
  end

  target 'SlowEatUITests' do
    inherit! :search_paths
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end
