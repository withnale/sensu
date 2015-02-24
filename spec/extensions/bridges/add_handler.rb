module Sensu
  module Extension
    class AddHandler < Handler
      def name
        'add_handler'
      end

      def description
        'route events to other handlers'
      end

      def run(event, &block)
=begin
        case event[:client][:name]
          when 'test-client-2'
            added_handlers = [
                {
                    :name => 'file',
                    :override => {
                        :command => 'cat > /tmp/some.other.file'
                    }
                },
                {
                    :name => 'file'
                }
            ]
          else
        end
=end
        added_handlers = [
            {
                :name => 'file',
                :override => {
                    :command => 'cat > /tmp/some.other.file'
                }
            },
            {
                :name => 'file'
            }
        ]
        yield 'wrote event data to /tmp/sensu-event.json', 0, added_handlers
      end
    end
  end
end
