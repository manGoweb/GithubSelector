#
# Be sure to run `pod lib lint GithubSelector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GithubSelector'
  s.version          = '0.0.3'
  s.summary          = 'Github API enabled file selector written in Swift.'

  s.description      = "GithubSelector is a file browser that allows you to brows through all your repos using github API V3. You can browse any repo you have access to, private or public, yours or a fork while switching branches or selecting any historic commit you might need. Once done, file will be downloaded and passed back onto you in closure with all the info and content of your file as plain Data."

  s.homepage         = 'https://github.com/manGoweb/GithubSelector'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ondrej Rafaj' => 'dev@mangoweb.cz' }
  s.source           = { :git => 'https://github.com/manGoweb/GithubSelector.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rafiki270'

  s.ios.deployment_target = '10.1'

  s.source_files = 'GithubSelector/Classes/**/*'
  
  #s.resource_bundles = {
  #  'GithubSelector' => ['GithubSelector/Localization/*.lproj']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit', '~> 3.2.0'
  s.dependency 'Presentables', '~> 0.1.3'
  s.dependency 'NBNRequestKit', '~> 2.0.2'
end
