module BugherdClient
  module Resources
    module V1

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

        #
        # Create a Project, will initially have no members
        # attributes: name, devurl, is_public, is_active
        #
        def create(attributes={})
          raw_response = post_request("projects", project: attributes)
          parse_response(raw_response, :project)
        end

        #
        # Update settings for an existing project under your control (ie: only the ones you own).
        #
        def update(project_id, attributes={})
          raw_response = put_request("projects/#{project_id}", project: attributes)
          parse_response(raw_response, :project)
        end

        # 
        # Delete a project and all associated data. Use with care, deleted projects cannot be recovered.
        #
        def delete(project_id)
          raw_response = delete_request("projects/#{project_id}")
          parse_response(raw_response)
        end

      end
      
    end
  end
end