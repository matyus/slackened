# typed: false
# frozen_string_literal: true

Gem::Specification.new do |s|
	s.name        = 'slackened'
	s.version     = '0.0.2'
	s.licenses    = ['MIT']
	s.summary     = 'Interact with Slack'
	s.description = 'A lightweight interface interacting with the Slack APIs'
	s.authors     = ['Michael Matyus']
	s.email       = 'michael@maty.us'
	s.files       = Dir['lib/**/*']
	s.homepage    = 'https://github.com/matyus/slackened'
	s.metadata    = {
		'rubygems_mfa_requirea' => 'true',
		'source_code_uri' => 'https://github.com/matyus/slackened'
	}
	s.required_ruby_version = '>= 3.2.2'
	s.post_install_message = 'Slack stands for: Searchable Log of All Communication and Knowledge'
	s.requirements << '"Activate incoming webhooks" in your Slack App settings'
	s.requirements << 'A valid webhook endpoint URL provided by Slack'
	s.requirements << 'Store the entire URL in an ENV variable outside your application'
	s.cert_chain  = ['certs/matyus.pem']
	s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
end
