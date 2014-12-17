module BugherdClient
  module Resources
    module V2

      class Task < Base

        PRIORITIES = ['not set', 'critical', 'important', 'normal','minor']
        PRIORITIES.each { |p| Task.const_set("PRIORITY_#{p.gsub(' ', '').upcase}", p) }
        def priorities
          self.class::PRIORITIES
        end

        STATUSES = ['backlog','todo','doing','done','closed']
        STATUSES.each { |s| Task.const_set("STATUS_#{s.upcase}", s) }
        def statuses
          self.class::STATUSES
        end

        VALID_QUERY_KEYS = [:page, :updated_since, :created_since, :status, :priority, :assigned_to_id, :external_id]

        #
        # Get a full list of tasks for a project, including archived tasks.
        # filters: updated_since, created_since, status, priority, tag,
        #          assigned_to_id, and external_id.
        #
        # example:
        #
        # client.tasks.all(45, { status: 'backlog' })
        #
        def all(project_id, filter_attributes={})
          params = filter_attributes.empty? ? {} : { params: filter_attributes }
          validate_filter_attributes!(filter_attributes) unless filter_attributes.empty?
          raw_response = get_request("projects/#{project_id}/tasks", params)
          parse_response(raw_response, :tasks)
        end

        #
        # List details of a task in a given project, includes all data including comments, attachments, etc.
        #
        def find(project_id, task_id)
          raw_response = get_request("projects/#{project_id}/tasks/#{task_id}")
          parse_response(raw_response, :task)
        end

        #
        # Create a new Task
        # attributes:
        #   description, priority, status, tag_names(Array),
        #   requester_id or requester_email,
        #   assigned_to_id or assigned_to_email
        #   external_id
        # if status is null the Task is automatically put in the Feedback panel
        # 'requester_email' can be any email address while 'assigned_to_email' needs to be of a current project member.
        # Values for 'priority' are not set, critical, important, normal, and minor.
        # Values for 'status' are backlog, todo, doing, done, and closed. Omit this field or set as 'null' to send tasks to the Feedback panel.
        # External ID is an API-only field. It cannot be set from the BugHerd application, only using the API. An external ID can be used to track originating IDs from other systems in BugHerd bugs.
        def create(project_id, attributes={})
          raw_response = post_request("projects/#{project_id}/tasks", task: attributes)
          parse_response(raw_response)
        end

        def update(project_id, task_id, attributes={})
          raw_response = put_request("projects/#{project_id}/tasks/#{task_id}", task: attributes)
          parse_response(raw_response)
        end

        private
          def validate_filter_attributes!(input_filters = {})
            input_filters.keys.compact.each do |k|
              unless VALID_QUERY_KEYS.include?(k.to_sym)
                raise(BugherdClient::Errors::InvalidQueryKey.new(k, VALID_QUERY_KEYS))
              end
            end
          end

      end

    end
  end
end
