# require 'ext/gem_rake'

require 'bundler'
Bundler::GemHelper.install_tasks

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

