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


  it "should search_rails_config_secrets" do
    repository = Repository.new 'https://github.com/RaspberryCook/website'

    puts repository.search_rails_config_secrets.inspect

    expect(repository.search_rails_config_secrets).to eq([{"development"=>{"marmiton_password"=>"20462046"}, "production"=>{"marmiton_password"=>"20462046"}, "test"=>{"marmiton_password"=>"20462046"}}])
  end
end
