namespace :yarn do

  desc "Install package dependencies using yarn."
  task :install do
    command %{
      echo "-----> Installing package dependencies using yarn"
      #{echo_cmd %[#{fetch(:yarn_bin)} install #{fetch(:yarn_options)}]}
    }
  end

  desc "Install latest version of yarn."
  task :setup do
    command %{
      echo "-----> Installing yarn"
      #{echo_cmd %[npm install -g yarn]}
    }
  end
end