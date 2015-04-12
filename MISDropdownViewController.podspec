#
#  Be sure to run `pod spec lint MISDropdownViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  Any lines starting with a # are optional, but encouraged
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = 'MISDropdownViewController'
  s.version      = '1.0.0'
  s.summary      = 'Simple UI component that represents content as dropdown on iPhone and popover on iPad by default.'
  s.description  = <<-DESC
                    Simple UI component that represents the content as dropdown on iPhone and popover on iPad by default.

                    Configurable to show the content always as dropdown or as popover (iPad only) and configure if the dropdown should appear at the top or bottom.

                    MISDropdownViewController uses ARC and supports iOS 7.0+
                   DESC
  s.homepage     = 'https://github.com/maicki/MISDropdownViewController'
  s.license      = 'MIT'
  s.author       = { 'Michael Schneider' => 'mischneider1@gmail.com' }
  # s.social_media_url   = 'http://twitter.com/maicki'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source       = { :git => 'https://github.com/maicki/MISDropdownViewController.git', :tag => s.version.to_s }
  s.source_files = 'MISDropdownViewController'
  s.public_header_files = 'MISDropdownViewController/**/*.h'
  s.frameworks   = 'UIKit'

end
