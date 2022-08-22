class SyncOrganizationRepoJob < BaseJob
  queue_as :default

  sidekiq_options retry: false
end
