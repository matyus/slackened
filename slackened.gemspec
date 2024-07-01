# typed: false
# frozen_string_literal: true

Gem::Specification.new do |s| # rubocop:disable Gemspec/RequireMFA
	s.name        = 'slackened'
	s.version     = '0.0.1.pre'
	s.licenses    = ['MIT']
	s.summary     = 'Interact with Slack'
	s.description = 'A lightweight interface interacting with the Slack APIs'
	s.authors     = ['Michael Matyus']
	s.email       = 'michael@maty.us'
	s.files       = Dir['lib/**/*']
	s.homepage    = 'https://rubygems.org/gems/slackened'
	s.metadata    = {
		'rubygems_mfa_requirea' => 'true',
		'source_code_uri' => 'https://github.com/matyus/slackened'
	}
	s.required_ruby_version = '>= 3.2.2'
	s.post_install_message = 'Slack stands for: Searchable Log of All Communication and Knowledge'
	s.requirements << '"Activate incoming webhooks" feature via https://api.slack.com/messaging/webhooks'
	s.requirements << 'Create a valid webhook endpoint URL provided by Slack'
	s.requirements << 'Store the entire URL in an ENV variable outside your application'
end
