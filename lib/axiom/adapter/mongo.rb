require 'axiom'
require 'mongo'

module Axiom
  module Adapter
    # An adapter for mongodb
    class Mongo
      # Error raised when query on unsupported algebra is created
      class UnsupportedAlgebraError < StandardError; end

      include Adamantium::Flat

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

      def execute(relation)
        Query.new(@database, relation).execute
      end

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

require 'axiom/adapter/mongo/operations'
require 'axiom/adapter/mongo/visitor'
require 'axiom/adapter/mongo/function'
require 'axiom/adapter/mongo/literal'
require 'axiom/adapter/mongo/gateway'
require 'axiom/adapter/mongo/query'
