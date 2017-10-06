target 'CricHQTest' do
    use_frameworks!
    platform :ios, '9.0'

    pod 'SwiftLint', '0.22.0', :configurations => 'Debug'
    pod 'Then', '2.2.0'
    pod 'Alamofire', '4.5.1'
    pod 'RxSwift' , '4.0.0-beta.0'
    pod 'KeyedAPIParameters', '0.1'
    pod 'SnapKit', '4.0.0'
    pod 'XMLDictionary', '1.4.1'
end

swift_32 = ['SwiftLint', 'Alamofire', 'KeyedAPIParameters']
swift4 = ['KeyboardObserver', 'SnapKit', 'RxSwift', 'Then']

post_install do |installer|
    installer.pods_project.targets.each do |target|
        swift_version = nil
        
        if swift_32.include?(target.name)
            swift_version = '3.2'
        end
        
        if swift4.include?(target.name)
            swift_version = '4.0'
        end
        
        if swift_version
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = swift_version
            end
        end
    end
end
