# typed: false
# frozen_string_literal: true

Gem::Specification.new do |s|
	s.name        = 'slackened'
	s.version     = '0.0.5'
	s.licenses    = ['MIT']
	s.summary     = 'Interact with your Slack apps'
	s.description = 'A lightweight interface interacting with your Slack app via the web APIs'
	s.authors     = ['Michael Matyus']
	s.email       = 'michael@maty.us'
	s.files       = Dir['lib/**/*']
	s.homepage    = 'https://github.com/matyus/slackened'
	s.metadata    = {
		'rubygems_mfa_requirea' => 'true',
		'source_code_uri' => 'https://github.com/matyus/slackened',
		'rubygems_mfa_required' => 'true'
	}
	s.required_ruby_version = '>= 3.3.0'
	s.post_install_message = 'Did you know that Slack stands for: Searchable Log of All Communication and Knowledge?'
	s.requirements << '"Activate incoming webhooks" in your Slack App settings, store the URL outside of your codebase'
	s.cert_chain  = ['certs/matyus.pem']
	s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $PROGRAM_NAME =~ /gem\z/
end
