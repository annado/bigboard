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
