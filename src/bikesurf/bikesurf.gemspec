Gem::Specification.new do |s|
  s.require_paths = ['lib']
  s.name          = 'bikesurf'
  s.version       = '0.1.0'
  s.description   = "BikeSurf site"
  s.authors       = ["Diana Geneva", "Zvezdalina Dimitrova", "Georgi Pavlov", "Angel Angelov"]
  s.summary       = "Bike sharing platform"
  s.email         = 'dageneva@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.homepage      =
    'https://github.com/bitterfly/bikesurf'
  s.license       = 'MIT'
  s.executables   = []
  s.add_development_dependency 'rspec', '~> 3'
end
