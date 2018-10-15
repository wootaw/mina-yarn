# Mina-yarn

Yarn tasks for mina 1.x

## Installation

To use it in your project's deployment process install this gem with the following command:

    $ gem install mina-yarn

Add the following line to your deploy.rb script:

```ruby
require 'mina/yarn'
```

This enables you to use the `yarn:install` task in your deploy script.

## Configuration

__Important:__ The `:yarn_bin` defaults to `yarn`
__Important:__ The `:yarn_options` defaults to `--production`

To change `yarn_bin` add `yarn_options` in your `deploy.rb` file:

```Ruby
set :yarn_bin, 'yarn_other'
set :yarn_options, lambda { %{--production --ignore-engines} }
```

## Example deploy script

```Ruby
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/yarn' # <---- Added this line

set :domain, 'my-page.com'
set :deploy_to, '/home/deploy/www/...'
set :repository, 'https://github.com/...'
set :branch, 'master'
set :yarn_bin, '.yarn_other' # <--- Added this line
set :yarn_options, lambda { %{--production --ignore-engines} } # <--- Added this line

...

desc "Deploys the current version to the server."
task :deploy => :remote_environment do

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'yarn:install' # <----- Added this line
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %[touch "#{fetch(:deploy_to)}/tmp/restart.txt"]
      end
    end
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mina::Yarn project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mina-yarn/blob/master/CODE_OF_CONDUCT.md).
