platform :ios, '13.0'
inhibit_all_warnings!

workspace 'ComponentsHub'

target 'DemoApp' do

  project 'DemoApp/DemoApp.xcodeproj'

  use_frameworks!
#  use_frameworks! :linkage => :static

  pod 'RxSwift' , '5.1.1'

  #target 'DemoApp_Tests' do
  #  inherit! :search_paths
  #  pod 'Kiwi'
  #end
end

target 'ComponentA' do
  use_frameworks!
  #use_frameworks! :linkage => :static

  project 'ComponentA/ComponentA.xcodeproj'

  pod 'RxSwift', '5.1.1'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
  end
end
