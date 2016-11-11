clearing :on

notification :libnotify, timeout: 3, transient: true, append: false

guard :bundler do
  require "guard/bundler"
  require "guard/bundler/verify"
  helper = Guard::Bundler::Verify.new

  files = ["Gemfile"]
  files += Dir["*.gemspec"] if files.any? { |f| helper.uses_gemspec?(f) }
  files.each { |file| watch(helper.real_path(file)) }
end

group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: "export $(cat .env.test) && rspec" do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch("spec/spec_helper.rb")  { "spec" }
  end

  guard :rubocop, all_on_start: true,
                  cli: ["--auto-correct", "--display-cop-names"] do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
