%w(
  .ruby-version and
  .rbenv-vars and
  tmp/restart.txt and
  tmp/caching-dev.txt
).each { |path| Spring.watch(path) }
