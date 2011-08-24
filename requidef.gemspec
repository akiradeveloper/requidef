# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{requidef}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Akira Hayakawa}]
  s.date = %q{2011-08-24}
  s.description = %q{Which do you use for your requirement definition job? MS Excel? MS Word? Uninstall them. Because you will get a better solution.}
  s.email = %q{ruby.wktk@gmail.com}
  s.executables = [%q{Makefile}, %q{requidef}, %q{requidef.rb}, %q{sample.html}, %q{sample.mm}, %q{sample.rd}, %q{sample2.rd}, %q{requidef}]
  s.extra_rdoc_files = [
    "ChangeLog.md",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "lib/generic/matrix.rb",
    "lib/generic/matrix2csv.rb",
    "lib/generic/row_of_nodes.rb",
    "lib/generic/tree.rb",
    "lib/generic/tree2matrix.rb",
    "lib/html2rd.rb",
    "lib/mm2rdtree.rb",
    "lib/rd2rdnodes.rb",
    "lib/rd2rdtree.rb",
    "lib/rdnode.rb",
    "lib/rdnodes2rdtree.rb",
    "lib/rdtree.rb",
    "lib/rdtree2dot.rb",
    "lib/rdtree2rd.rb",
    "lib/requidef.rb"
  ]
  s.homepage = %q{http://github.com/akiradeveloper/requidef}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Requiem for your Requirement Definition}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<hpricot>, [">= 0.8.4"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<hpricot>, [">= 0.8.4"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<hpricot>, [">= 0.8.4"])
  end
end

