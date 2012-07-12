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

      # Read tuples from relation
      #
      # @param [Relation] relation
      #   the relation to read from
      #
      # @return [self]
      #   returns self when block given
      #
      # @return [Enumerable<Array>]
      #   returns enumerable when no block given
      #
      # @api private
      #
      def read(relation, &block)
        return to_enum(__method__, relation) unless block_given?

        Query.new(@database, relation).each(&block)

        self
      end

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

require 'veritas/adapter/mongo/operations'
require 'veritas/adapter/mongo/visitor'
require 'veritas/adapter/mongo/function'
require 'veritas/adapter/mongo/literal'
require 'veritas/adapter/mongo/gateway'
require 'veritas/adapter/mongo/query'
