# frozen_string_literal: true

class SyncOrganizationRepoJob < BaseJob
  queue_as :default

  sidekiq_options retry: false
end
