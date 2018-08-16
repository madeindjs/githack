require 'tmpdir'
require 'fileutils'

require 'git'


class Repository

  attr_reader :git, :remote, :name

  def initialize remote
    @remote = remote
    @name = remote.gsub /[^0-9A-Z]/i, '_'
    FileUtils.rm_rf(self.path)
    @git = Git.clone @remote, @name, path: Dir.tmpdir
  end

  def path
    return File.join(Dir.tmpdir, self.name)
  end


end
