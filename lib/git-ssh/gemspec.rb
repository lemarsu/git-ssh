require 'rubygems'
require 'git-ssh/specification'
require 'git-ssh/version'
require 'rake'

# The Gem Specification plus some extras for git-ssh.
module GitSsh
  SPEC = GitSsh::Specification.new do |spec|
    spec.name               = "git-ssh"
    spec.version            = GitSsh::VERSION
    spec.rubyforge_project  = "git-ssh"
    spec.author             = "LeMarsu"
    spec.email              = "ch.ruelle@lemarsu.com"
    spec.homepage           = "http://git-ssh.rubyforge.org/"

    spec.summary            = "A Summary of git-ssh."
    spec.description        = <<-DESC
		A longer more detailed description of git-ssh.
		DESC

    spec.extra_rdoc_files   = FileList["[A-Z]*"]
    spec.has_rdoc           = true
    spec.rdoc_main          = "README"
    spec.rdoc_options       = [ "--line-numbers" , "--inline-source" ]

    spec.test_files         = FileList["spec/**/*.rb", "test/**/*.rb"]
    spec.files              = spec.test_files + spec.extra_rdoc_files + 
      FileList["lib/**/*.rb", "resources/**/*"]

    spec.executable         = spec.name


    # add dependencies
    # spec.add_dependency("somegem", ">= 0.4.2")

    spec.platform           = Gem::Platform::RUBY

    spec.local_rdoc_dir     = "doc/rdoc"
    spec.remote_rdoc_dir    = "#{spec.name}/rdoc"
    spec.local_coverage_dir = "doc/coverage"
    spec.remote_coverage_dir= "#{spec.name}/coverage"

    spec.remote_site_dir    = "#{spec.name}/"

  end
end


