# frozen_string_literal: true

require_relative 'base'

module Slackened
	module BlockKit
		# proof of concept
		module Blocks
			class Actions < Slackened::BlockKit::Blocks::Base
				MAX_LENGTH = 25
				ELEMENTS = %i[
					button checkboxes datepicker datetimepicker email_text_input file_input image multi_static_select
					multi_external_select multi_users_select multi_conversations_select multi_channels_select
					number_input overflow plain_text_input radio_buttons rich_text_input option_groups external_select
					users_select conversations_select channels_select timepicker url_text_input workflow_button
				].freeze

				def initialize(*elements) # rubocop:disable Lint/MissingSuper
					raise MinimumElementsError if elements.empty?
					raise MaximumElementsError, "#{elements.count} can't be greater than #{MAX_LENGTH}" if elements.length > MAX_LENGTH

					set({
						type: :actions,
						elements: elements.map do |element|
							raise InvalidElement unless ELEMENTS.include? element.block[:type]

							element
						end
					})
				end
			end
		end
	end
end
