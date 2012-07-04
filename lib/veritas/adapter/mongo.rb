require 'veritas'
require 'mongo'

module Veritas
  module Adapter
    # An adapter for mongodb
    class Mongo
      # Error raised when query on unsupported algebra is created
      class UnsupportedAlgebraError < StandardError; end

      include Immutable


      # Return mongo connection
      # 
      # @return [::Mongo::Connection]
      #
      # @api private
      #
      attr_reader :connection

      private

      # Initialize mongo adapter
      #
      # @param [Mongo::Connection] connection
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(connection)
        @connection = connection
      end

      # Create new mongo adapter
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.new(*args)
        args = args.first if args.length == 1 
        connection = 
          case args
          when ::Mongo::Connection, ::Mongo::ReplSetConnection
            args
          when Array
            ::Mongo::Connection.new(*args)
          else
            raise ArgumentError,"Cannot construct connection from #{args.inspect}"
          end

        super(connection)
      end
    end
  end
end

require 'veritas/adapter/mongo/gateway'
