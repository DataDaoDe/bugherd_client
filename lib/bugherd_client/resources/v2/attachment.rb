module BugherdClient
  module Resources
    module V2

      class Attachment < Base

        # LIST
        #
        # Get a paginated list of attachments for a task.
        # GET /api_v2/projects/#{project_id}/tasks/#{task_id}/attachments.json
        def all
        end

        # SHOW
        #
        # Get detail for specific attachment.
        # GET /api_v2/projects/#{project_id}/tasks/#{task_id}/attachments/#{id}.json
        def find(project_id, task_id, attachment_id)
        end

        # CREATE
        #
        # Adds a new attachment to the specified task using an existing URL.
        # POST /api_v2/projects/#{project_id}/tasks/#{task_id}/attachments.json
        #
        # PARAMS
        # {'comment':{
        #   'file_name':'resolution.gif',
        #   'url':'http://i.imgur.com/U9h3jZI.gif'
        # }}
        def create(project_id, task_id, payload)
        end

        # UPLOAD
        #
        # Upload a new attachment and add it to the specified task.
        # The file contents need to be specified as the POST data on this request.
        #
        # Note that your upload needs to be reasonable in size as the maximum time the request
        # may take is around 30 seconds.
        # If you have larger uploads please create arrange your own file upload
        # and create the attachment from a URL instead.
        #
        # POST /api_v2/projects/#{project_id}/tasks/#{task_id}/attachments/upload
        #
        # Note in the sample below please specify an existing file name.
        def upload(projet_id, task_id, payload)
        end

        # DELETE
        #
        # Delete an attachment from a task. Note that this action is permanent and cannot be undone.
        # DELETE /api_v2/projects/#{project_id}/tasks/#{task_id}/attachments/#{id}.json
        def delete
        end

      end

    end # V2
  end # Resources
end # BugherdClient
