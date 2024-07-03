# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Section < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 10

				def initialize(*fields) # rubocop:disable Metrics/MethodLength
					raise MaximumFieldsError, "#{fields.count} can't be greater than #{MAX_LENGTH}" if fields.length > MAX_LENGTH
					raise MustBeString unless fields.all? { |f| f.is_a? String }

					if fields.one?
						set({
							type: :section,
							text: Text.new(fields.first)
						})

						return self
					end

					set({
						type: :section,
						fields: fields.map { |f| Text.new(f) }
					})

					self
				end
			end
		end
	end
end
