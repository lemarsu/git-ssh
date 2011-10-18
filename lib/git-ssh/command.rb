require 'optparse'

class GitSsh::Command

  COMMANDS_RE = /^(git-(?:receive|upload)-pack) '(.*)'$/o
  SSH_COMMAND = 'SSH_ORIGINAL_COMMAND'

  class UsageError < Exception; end
  class ShellError < Exception; end

  Options = Struct.new("Options", :verbose, :chroot)

  def initialize(*args)
    parse_args(*args)
    parse_ssh_original_command
  end

  def run
    exec *command_line
    STDERR.puts "Exec sucked!"
  end

  def command_line
    path = @options.chroot ? File.join(@options.chroot, @path) : @path
    [@command, path]
  end

  private

  def parse_args(*args)
    @args = args
    @options = Options.new(false, false)
    parser = get_parser
    args_left = parser.parse!(@args)
    raise UsageError, "#$0 usage: #$0 <user>" unless
      args_left.size == 1 && args_left.first =~ /^\S+$/
    @user = @args.first
  end

  def get_parser
    OptionParser.new do |o|
      o.banner = "Usage: #$0 [options] <user>"

      o.separator ""
      o.separator "Options:"

      o.on '-r DIR', '--chroot=DIR', 'Chroot the user' do |value|
	@options.chroot = value
      end
      o.on('-v', '--verbose', 'Be verbose') { @options.verbose = true }
      o.on('-V', '--version', 'Get the version') do
	puts "#$0 v#{GitSsh::VERSION}"
	exit 0
      end
    end
  end

  def parse_ssh_original_command
    raise ShellError, "What do you think I am? A shell?" unless
      ENV.keys.include?(SSH_COMMAND)
    raise ShellError, "It seems dangerous" unless
      mg = COMMANDS_RE.match(ENV[SSH_COMMAND])
    @command = mg[1]
    @path = sanitize_path mg[2]
  end

  def sanitize_path(path)
    test_path = path[0] == ?/ ? path : File.join('/', path)
    File.expand_path(test_path)
  end

end
