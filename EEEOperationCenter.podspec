Pod::Spec.new do |s|
  s.name             = "EEEOperationCenter"
  s.version          = "1.1.0"
  s.summary          = "Say 'no' to God-classes, chop them up with the operation center"
  s.homepage         = "https://github.com/epologee/EEEOperationCenter"
  s.license          = 'Unlicense'
  s.author           = { "Eric-Paul Lecluse" => "e@epologee.com" }
  s.source           = { :git => "https://github.com/epologee/EEEOperationCenter.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/epologee'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  s.dependency 'EEEInjector', '~> 1.0'
end
