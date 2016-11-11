web:    bundle exec thin start -p $PORT -V -e production
worker: bundle exec sidekiq -C config/sidekiq.yml -r ./lib/workers/*
clock:  clockwork sheduler.rb