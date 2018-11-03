# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Zaha' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

   pod 'Alamofire', '4.7.3'
   pod 'MOLH', '0.4'
   pod 'IQKeyboardManagerSwift', '6.2.0'
  pod 'Kingfisher', '4.10.0'
   pod 'MICountryPicker', :git => 'https://github.com/mustafaibrahim989/MICountryPicker.git', :branch => 'master'
    pod 'RealmSwift'
    pod 'SwiftMessages'
    pod 'GoogleSignIn'
  # Pods for Zaha
  # Pods for Zaha

  target 'ZahaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ZahaUITests' do
    inherit! :search_paths
    # Pods for testing
  end


  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['MICountryPicker'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
    end
