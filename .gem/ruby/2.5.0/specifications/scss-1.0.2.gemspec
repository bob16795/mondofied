# -*- encoding: utf-8 -*-
# stub: scss 1.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "scss".freeze
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Henrik Nyh".freeze]
  s.date = "2015-02-22"
  s.email = ["henrik@nyh.se".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "\nNOTE: The gem is called \"sass\", not \"scss\"! Get rid of the \"scss\" gem and try again.\n\n".freeze
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Placeholder gem to tell you that you wanted \"sass\".".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
