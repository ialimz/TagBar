Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "TagBar"
s.summary = "Create tags like a pro"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Ali Moazenzadeh" => "alimz@divar.ir" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/ialimz/TagBar"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/ialimz/TagBar.git",
:tag => "#{s.version}" }

# 8
s.source_files = "TagBar/**/*.{swift}"

# 9
s.resources = "TagBar/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end
