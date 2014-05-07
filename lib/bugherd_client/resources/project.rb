module BugherdClient
  module Resources
    class Project < Base

      #
      # Get more detail of your account.
      # API: 1,2
      def all
        raw_response = self.connection['projects'].get
        parse_response(raw_response, :projects)
      end

      #
      # Get all active projects
      #
      def active
        raw_response = self.connection['projects/active'].get
        parse_response(raw_response, :projects)
      end
    end
  end
end