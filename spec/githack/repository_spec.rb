require 'tmpdir'

RSpec.describe Repository do
  it "should clone repository" do
    repository = Repository.new 'https://github.com/RaspberryCook/website'

    expect(File.directory?(repository.path)).to be true
  end

  it "should search_rails_config_database" do
    repository = Repository.new 'https://github.com/RaspberryCook/website'

    expect(repository.search_rails_config_database).to eq([{"adapter"=>"mysql2", "database"=>"raspberry_cook", "encoding"=>"utf8", "username"=>"raspberry_cook", "password"=>"secret", "host"=>"localhost", "pool"=>5, "timeout"=>5000}])
  end
end
