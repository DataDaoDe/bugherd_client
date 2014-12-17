module BugherdClient
  module Resources
    module V2

      class Project < Base

        #
        # Get more detail of your account.
        #
        def all
          raw_response = get_request('projects')
          parse_response(raw_response, :projects)
        end

        #
        # Show details for a specific project
        #
        def find(project_id)
          raw_response = get_request("projects/#{project_id}")
          parse_response(raw_response, :project)
        end

        # CREATE
        #
        # Create a new project. The project will initially have no members.
        # POST /api_v2/projects.json
        #
        # PARAMS:
        # {
        #   "name": "My Website",
        #   "devurl": "http://www.example.com",
        #   "is_active": true,
        #   "is_public": false
        # }
        #
        def create(attributes={})
          raw_response = post_request('projects', project: attributes)
          parse_response(raw_response, :project)
        end

        #
        # Update settings for an existing project under your control (ie: only the ones you own).
        # API: 1,2
        def update(project_id, attributes={})
          raw_response = put_request("projects/#{project_id}", project: attributes)
          parse_response(raw_response, :project)
        end

        #
        # Delete a project and all associated data. Use with care, deleted projects cannot be recovered.
        # API: 1,2
        def delete(project_id)
          raw_response = delete_request("projects/#{project_id}")
          parse_response(raw_response)
        end

        #
        # Add an existing guest to a project, or invite someone by email address.
        # required: project_id
        # attributes: user_id, email
        # API: 2
        def add_guest(project_id, attributes={})
          raw_response = post_request("projects/#{project_id}/add_guest", attributes)
          parse_response(raw_response, :project)
        end

        #
        # Add an existing guest to a project, or invite someone by email address.
        # required: project_id
        # attributes: user_id
        #
        def add_member(project_id, attributes={})
          raw_response = post_request("projects/#{project_id}/add_member", attributes)
          parse_response(raw_response, :project)
        end


        #
        # Get all active projects
        #
        def active
          raw_response = get_request('projects/active')
          parse_response(raw_response, :projects)
        end
      end

    end
  end
end
