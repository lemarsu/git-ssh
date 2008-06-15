class GitSsh::Command

  COMMANDS_RE = /^(git-(?:receive|upload)-pack) '(.*)'$/o
  ROOT_PATH = "/var/git_repositories"

  class UsageError < Exception; end

  def initialize(*args)
    raise "What do you think I am? A shell?" unless ENV.keys.include?("SSH_ORIGINAL_COMMAND")
    if mg = COMMANDS_RE.match(ENV['SSH_ORIGINAL_COMMAND'])
      @command = mg[1]
      @path = sanitize_path mg[2]
    else raise "It seems dangerous"
    end

    raise UsageError, "#$0 usage: #$0 <user>" unless args.size == 1 && args.first =~ /^\w+$/
    @user = args.first
  end

  def run
    exec *command_line
    STDERR.puts "Exec sucked!"
  end

  def command_line
    [@command, File.join(ROOT_PATH, @path)]
  end

  private

  def sanitize_path(path)
    test_path = path[0] == ?/ ? path : File.join('/', path)
    File.expand_path(test_path)
  end

end
