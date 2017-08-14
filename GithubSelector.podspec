#
# Be sure to run `pod lib lint GithubSelector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GithubSelector'
  s.version          = '0.1.0'
  s.summary          = 'Github API enabled file selector written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "This shall be good!"

  s.homepage         = 'https://github.com/Ondrej Rafaj/GithubSelector'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ondrej Rafaj' => 'dev@mangoweb.cz' }
  s.source           = { :git => 'https://github.com/Ondrej Rafaj/GithubSelector.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rafiki270'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GithubSelector/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GithubSelector' => ['GithubSelector/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit', '~> 3.2.0'
  s.dependency 'Presentables', '~> 0.1.0'
  s.dependency 'OctoKit.swift', '~> 0.7.3'
end
