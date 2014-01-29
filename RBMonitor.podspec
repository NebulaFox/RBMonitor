
Pod::Spec.new do |s|

  s.name         = "RBMonitor"
  s.version      = "1.0.1"
  s.summary      = "A synchronization construct with the ability to wait until signalled that a condition has been met."

  s.description  = <<-DESC
                   A synchronization construct with the ability to wait until signalled that a condition has been met.
                   An alternative to [TRVSMonitor](https://github.com/travisjeffery/TRVSMonitor).
                   DESC

  s.homepage     = "https://github.com/NebulaFox/RBMonitor"

  s.license      = 'NCSA'

  s.author             = { "Robbie Bykowski" => "robbie.bykowski@gmail.com" }
  s.social_media_url = "http://twitter.com/NebulaFox"

  # Could work on iOS 6, but haven't tested
  s.platform     = :ios, '7.0'

  s.source       = { :git => "https://github.com/NebulaFox/RBMonitor.git", :tag => "1.0.1" }

  s.source_files  = 'RBMonitor', 'RBMonitor/**/*.{h,m}'

  s.requires_arc = true
end
