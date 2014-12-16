module BugherdClient
  module CLI
    class Setup

      def config_dir
        File.join((ENV['BUGHERD_CONFIG_FILE'] || ENV['HOME']), '.bugherd')
      end

      def config_file
        File.join(config_dir, 'config.yml')
      end

      def read_configuration
        YAML.load_file(config_file)
      end
      
    end
  end
end
