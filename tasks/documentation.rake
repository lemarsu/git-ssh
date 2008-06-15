#-----------------------------------------------------------------------
# Documentation
#-----------------------------------------------------------------------

namespace :doc do

  # generating documentation locally
  Rake::RDocTask.new do |rdoc|
    rdoc.rdoc_dir   = GitSsh::SPEC.local_rdoc_dir
    rdoc.options    = GitSsh::SPEC.rdoc_options 
    rdoc.rdoc_files = GitSsh::SPEC.rdoc_files
  end

  desc "Deploy the RDoc documentation to #{GitSsh::SPEC.remote_rdoc_location}"
  task :deploy => :rerdoc do
    sh "rsync -zav --delete #{GitSsh::SPEC.local_rdoc_dir}/ #{GitSsh::SPEC.remote_rdoc_location}"
  end

  if HAVE_HEEL then
    desc "View the RDoc documentation locally"
    task :view => :rdoc do
      sh "heel --root  #{GitSsh::SPEC.local_rdoc_dir}"
    end
  end
end
