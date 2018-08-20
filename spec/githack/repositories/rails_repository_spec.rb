require 'tmpdir'

RSpec.describe Githack::Repositories::Rails do
  it 'should clone RailsRepository' do
    repository = Githack::Repositories::Rails.new 'https://github.com/RaspberryCook/website'

    expect(File.directory?(repository.path)).to be true
  end

  it 'should search database' do
    repository = Githack::Repositories::Rails.new 'https://github.com/RaspberryCook/website'

    expect(repository.databases).to eq([{ 'adapter' => 'mysql2', 'database' => 'raspberry_cook', 'encoding' => 'utf8', 'username' => 'raspberry_cook', 'password' => 'secret', 'host' => 'localhost', 'pool' => 5, 'timeout' => 5000 }])
  end

  it 'should search secrets' do
    repository = Githack::Repositories::Rails.new 'https://github.com/RaspberryCook/website'

    expect(repository.secrets).to eq([{ 'development' => { 'marmiton_password' => '20462046' }, 'production' => { 'marmiton_password' => '20462046' }, 'test' => { 'marmiton_password' => '20462046' } }])
  end
end
