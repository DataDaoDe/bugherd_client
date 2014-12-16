module BugherdClient
  module Resources
    module V2
      class Webhook < Base

        # LIST
        #
        # Get a list of currently installed webhooks.
        #
        # GET /api_v2/webhooks.json
        def all
          raw_response = get_request('webhooks')
          parse_response(raw_response, :webhooks)
        end

        # CREATE
        #
        # When installing a webhook, specify an event you wish to hook into.
        # Choose from: 'task_create', 'task_update', 'comment' or 'task_destroy'.
        # To get activity for all 3 events, create an entry for each event.
        #
        # 'project_id' is optional; it only needs to be specified if you'd only like
        # events on a specific project. Omitting 'project_id' results in notifications
        # of activity on all your projects.
        #
        # PARAMS
        # {
        #   'project_id':1,
        #   'target_url':'https://app.example.com/api/bugherd_sync/project/1/task_create',
        #   'event':'task_create'
        # }
        #
        def create(payload = {})
          raw_response = post_request('webhooks', payload)
          parse_response(raw_response, :webhook)
        end

        # DELETE
        #
        # DELETE /api_v2/webhooks/#{id}.json
        def delete(webhook_id)
          raw_response = delete_request("webhooks/#{webhook_id}")
          parse_response(raw_response)
        end

      end
    end # V2
  end # Resources
end # BugherdClient
