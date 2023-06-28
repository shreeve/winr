# encoding: utf-8

Gem::Specification.new do |s|
  s.name        = "winr"
  s.version     = `grep -m 1 '^\s*@version' bin/winr | cut -f 2 -d '"'`
  s.author      = "Steve Shreeve"
  s.email       = "steve.shreeve@gmail.com"
  s.summary     =
  s.description = "A quick and lightweight benchmarking tool for Ruby"
  s.homepage    = "https://github.com/shreeve/winr"
  s.license     = "MIT"
  s.files       = `git ls-files`.split("\n") - %w[.gitignore]
  s.executables = `cd bin && git ls-files .`.split("\n")
end
