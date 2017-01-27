Gem::Specification.new do |s|
  s.require_paths = ['lib']
  s.name          = 'bikesurf'
  s.version       = '0.1.0'
  s.description   = "BikeSurf site"
  s.authors       = ["Zvezdalina Dimitrova", "Georgi Pavlov", "Angel Angelov", "Diana Geneva"]
  s.summary       = "Bike sharing platform"
  s.email         = ["zvezdi.dim@gmail.com", "georgipavlov94@gmail.com", "hextwoa@gmail.com", "dageneva@gmail.com"]
  s.files         = `git ls-files`.split("\n")
  s.homepage      =
    'https://github.com/bitterfly/bikesurf'
  s.license       = 'MIT'
  s.executables   = []
  s.add_runtime_dependency 'dotenv-rails', '~> 2'
  s.add_development_dependency 'rspec', '~> 3'
end
