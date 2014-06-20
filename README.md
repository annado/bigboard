bigboard
========

* Changelog kept by PaperTrail https://github.com/airblade/paper_trail
* Bower: rake bower:install


Setup tips
=========

* Setting up Rails with Postgres: https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres (Joyce stopped after gem install pg, then did 'bundle install', 'rake db:migrate', and 'rails server' and it all worked)
* If you have trouble with 'gem install pg', try using 'env ARCHFLAGS="-arch x86_64" gem install pg'
* App deploys continuously. just push and it will show up on https://big-board.herokuapp.com/boards/2
