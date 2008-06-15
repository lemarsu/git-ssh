class GitSsh::Command

  COMMANDS_RE = /^(git-(?:receive|upload)-pack) '(.*)'$/o
  ROOT_PATH = "/var/git_repositories"

  def initialize(*args)
    raise "What do you think I am? A shell?" unless ENV.keys.include?("SSH_ORIGINAL_COMMAND")
    if mg = COMMANDS_RE.match(ENV['SSH_ORIGINAL_COMMAND'])
      @command = mg[1]
      puts "before sanitize : #{mg[2]}"
      @path = sanitize_path mg[2]
    else raise "It seems dangerous"
    end

    p [@command, @path]
    unless args.size == 1 && args.first =~ /^\w+$/
      STDERR.puts "#$0 usage: #$0 <user>"
      exit 2
    end
    @user = args.first
  end

  def run
    STDERR.puts "Command line : #{ARGV.inspect}"
    # STDERR.puts "ENV : #{ENV.inspect}"

    path = File.join(ROOT_PATH, @path)
    cmd = [@command, path]
    STDERR.puts "CMD : #{cmd.join(' ')}"

    exec *cmd
    STDERR.puts "Exec sucked!"
  end

  private

  def sanitize_path(path)
    # return path unless path[0] == ?/
    File.expand_path(File.join('/', path))
  end

end
