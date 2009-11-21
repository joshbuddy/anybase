begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "anybase"
    s.description = s.summary = "Numbers from anybase to anybase"
    s.email = "joshbuddy@gmail.com"
    s.homepage = "http://github.com/joshbuddy/anybase"
    s.authors = ["Joshua Hull"]
    s.files = FileList["[A-Z]*", "{lib,spec}/**/*"]
    s.add_dependency 'fuzzyhash', '>=0.0.9'
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
    rubyforge.remote_doc_path = ''
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'spec'
require 'spec/rake/spectask'
task :spec => 'spec:all'
namespace(:spec) do
  Spec::Rake::SpecTask.new(:all) do |t|
    t.spec_opts ||= []
    t.spec_opts << "-rubygems"
    t.spec_opts << "--options" << "spec/spec.opts"
    t.spec_files = FileList['spec/**/*_spec.rb']
  end

end

