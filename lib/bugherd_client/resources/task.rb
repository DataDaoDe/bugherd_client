module BugherdClient
  module Resources
    class Task < Base

      #
      # Get a full list of tasks for a project, including archived tasks.
      # filters: updated_since, created_since, status, priority, tag and external_id
      def all(project_id, filter_attributes={})
        if self.options[:api_version] < 2 && !filter_attributes.empty?
          raise BugherdClient::Errors::UnsupportedAttributes, :v2, filter_attributes.keys()
        end
        params = filter_attributes.empty? ? {} : { params: filter_attributes }
        raw_response = get_request("projects/#{project_id}/tasks", params)
        parse_response(raw_response, :tasks)
      end

    end
  end
end