# encoding: utf-8

Gem::Specification.new do |s|
  s.name        = "winr"
  s.version     = "1.0.1"
  s.author      = "Steve Shreeve"
  s.email       = "steve.shreeve@gmail.com"
  s.summary     =
  s.description = "A quick and lightweight benchmarking tool for Ruby"
  s.homepage    = "https://github.com/shreeve/winr"
  s.license     = "MIT"
  s.files       = `git ls-files`.split("\n") - %w[.gitignore]
  s.executables = `cd bin && git ls-files .`.split("\n")
end
