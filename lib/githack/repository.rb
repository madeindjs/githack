require 'tmpdir'
require 'git'


class Repository

  attr_reader :git, :remote, :name

  def initialize remote
    @remote = remote
    @name = remote.gsub /[^0-9A-Z]/i, '_'

    if File.directory?(self.path)
      @git = Git.open self.path
    else
      @git = Git.clone @remote, @name, path: Dir.tmpdir
    end
  end

  def path
    return File.join(Dir.tmpdir, self.name)
  end


end
