#
# Be sure to run `pod lib lint YFCalendar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YFCalendar"
  s.version          = "0.1.0"
  s.summary          = "A calendar view which can be easily customized and integrated to your own project."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    YFCalendar is a subclass of UIView which has lots of functions open for the users to better customize their calendar.
DESC

  s.homepage         = "https://github.com/pushian/YFCalendar"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "pushian" => "l@fooyo.sg" }
  s.source           = { :git => "https://github.com/pushian/YFCalendar.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YFCalendar/Classes/*'
  
  # s.resource_bundles = {
  #   'YFCalendar' => ['YFCalendar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
