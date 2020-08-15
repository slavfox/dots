## Omni Auth
require 'omnigollum'
require 'omniauth/strategies/github'

wiki_options = {
  :live_preview => false,
  :allow_uploads => true,
  :per_page_uploads => true,
  :allow_editing => true,
  :css => true,
  :js => true,
  :mathjax => true,
  :h1_title => true
}
Precious::App.set(:wiki_options, wiki_options)
Precious::App.set(:gollum_path, '/var/gollum/wiki')

Gollum::Hook.register(:post_commit, :hook_id) do |committer, sha1|
    system('git push')
end

options = {
  :providers => Proc.new do
    provider :github, ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"]
  end,
  :dummy_auth => false,
  :protected_routes => ['/*'],

  :author_format => Proc.new { |user| user.name },
  :author_email => Proc.new { |user| user.email },

  :authorized_users => ["slavfoxman@gmail.com"],
}

Precious::App.set(:omnigollum, options)
Precious::App.register Omnigollum::Sinatra
