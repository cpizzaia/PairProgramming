# Uncomment the next line to define a global platform for your project
platform :ios, '11.4'
use_frameworks!

def pods
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'SDWebImage'
end

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'PairProgramming' do
  inherit! :search_paths
  pods
end

target 'PairProgrammingTests' do
  inherit! :search_paths
  pods
  testing_pods
end
