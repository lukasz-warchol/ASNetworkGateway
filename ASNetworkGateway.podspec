Pod::Spec.new do |s|
  s.name     = 'ASNetworkGateway'
  s.version  = '0.0.4'
  s.license  = 'MIT'
  s.summary  = 'Wrapper classes for many popular network kits.'
  s.homepage = 'https://github.com/lukasz-warchol/ASNetworkGateway'
  s.author   = { 'Lukasz Warchol' => 'lwarchol87@gmail.com' }
  s.license  = { :type => 'MIT', :file => 'MIT.LICENSE' }
  s.source   = { :git => 'https://github.com/lukasz-warchol/ASNetworkGateway', :commit => "v#{s.version}" }
  s.platform     = :ios, '4.3'
  s.requires_arc = true
  
  s.source_files = 'Core/**/*.{h,m,mm}'
  
  s.subspec 'ASIHTTPrequest' do |asi|
	asi.source_files = 'Implementations/ASIHTTPRequest/**/*.{h,m}'
    asi.dependency 'ASIHTTPRequest',"1.8.1"
  end
  
  s.subspec 'MKNetworkKit' do |mknk|
	mknk.source_files = 'Implementations/MKNetworkKit/**/*.{h,m}'
    mknk.dependency 'MKNetworkKit',"0.85"
  end
end