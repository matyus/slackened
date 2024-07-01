# frozen_string_literal: true

require 'logger'

module Slackened
	# proof of concept
	module Logger
		def log
			@log ||= ::Logger.new($stdout)
		end

		def debug!
			@log.level = ::Logger::DEBUG
		end

		def info!
			@log.level = ::Logger::INFO
		end

		def warn!
			@log.level = ::Logger::WARN
		end
	end
end
