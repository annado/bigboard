bigboard
========

* Changelog kept by PaperTrail https://github.com/airblade/paper_trail
* Bower: rake bower:install


Setup tips
=========
* Install postgres first. Using homebrew is pretty easy. (you don't need to do the lunchy part, just start the server with 'postgres -D /usr/local/var/postgres') http://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/
* Setting up Rails with Postgres: https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres (Joyce stopped after gem install pg, then did 'bundle install', 'rails server', 'bin/rake db:create db:migrate' and it all worked)
* If you have trouble with 'gem install pg', try using 'env ARCHFLAGS="-arch x86_64" gem install pg'
* App deploys continuously. just push and it will show up on https://big-board.herokuapp.com/boards/2
* To make your local bigboard data look like the production bigboard, use <a href="https://devcenter.heroku.com/articles/heroku-postgres-import-export">this</a>.

Setting up Yammer Application to test locally
=========
* The Big Board apps authenticates with Yammer
* The application can be created by going to https://www.yammer.com/client_applications
* You should set the client_id and secret at config/secrets.yml
* You will need to set the expected redirect to http://0.0.0.0:3000/
* You will need to set the Javascript Origins to http://0.0.0.0
