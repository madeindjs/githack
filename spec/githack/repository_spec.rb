require 'tmpdir'

RSpec.describe Repository do
  it "should clone repository" do
    repository = Repository.new 'https://github.com/RaspberryCook/website'

    expect(File.directory?(repository.path)).to be true
  end
end
