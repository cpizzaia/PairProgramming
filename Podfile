# Uncomment the next line to define a global platform for your project
platform :ios, '11.4'
use_frameworks!

def pods
  pod 'Alamofire', '4.9.1'
  pod 'SwiftyJSON', '5.0.0'
  pod 'SDWebImage', '5.2.5'
end

def testing_pods
  pod 'Quick', '2.2.0'
  pod 'Nimble', '8.0.4'
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
