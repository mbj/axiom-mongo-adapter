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
      # @return [::Mongo::DB]
      #
      # @api private
      #
      attr_reader :database

    private

      # Initialize mongo adapter
      #
      # @param [Mongo::DB] database
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(database)
        @database = database
      end
    end
  end
end

require 'veritas/adapter/mongo/gateway'
