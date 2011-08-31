# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "requidef"
  gem.homepage = "http://github.com/akiradeveloper/requidef"
  gem.license = "MIT"
  gem.summary = %Q{Requiem for your Requirement Definition}
  gem.description = %Q{Which do you use for your requirement definition job? MS Excel? MS Word? Uninstall them. Because you will get a better solution.}
  gem.email = "ruby.wktk@gmail.com"
  gem.authors = ["Akira Hayakawa"]
  # dependencies defined in Gemfile

  gem.files = FileList["lib/**/*.rb"]
  gem.executables << "requidef"
  gem.executables << "rd"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "requidef #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace "requidef" do 

# TODO: Under-Engineering.
# grep the error line will lessen the future cost.
desc "run all the main routines and grep errors"
task "maintest" do
  result = []
  FileList["lib/**/*.rb"].each do |rb|
    dirname = File.dirname(rb)
    filename = File.basename(rb)
    cd dirname do
      result << `ruby #{filename}`
    end
  end
  puts result.join("\n") # .split("\n").delete_if { |x| x =~ "Error" }
end
end
