module Githack
  class Leak
    attr_reader :sha, :content, :file

    def initialize(sha, file)
      @sha = sha
      @file = file
      @content = File.read(file)
    end
  end
end
