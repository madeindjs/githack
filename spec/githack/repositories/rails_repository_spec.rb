require 'tmpdir'

RSpec.describe Githack::Repositories::Rails do
  it 'should clone RailsRepository' do
    repository = Githack::Repositories::Rails::V5.new 'https://github.com/RaspberryCook/website'

    expect(File.directory?(repository.path)).to be true
  end

  it 'should search database' do
    repository = Githack::Repositories::Rails::V5.new 'https://github.com/RaspberryCook/website'

    expect(repository.databases).not_to be_empty
  end

  it 'should search secrets' do
    repository = Githack::Repositories::Rails::V5.new 'https://github.com/RaspberryCook/website'

    expect(repository.secrets).not_to be_empty
  end
end
