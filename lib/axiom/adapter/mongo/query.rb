module Axiom
  module Adapter
    class Mongo
      # a query in mongo adapter
      class Query
        include Enumerable, Adamantium::Flat

        # Enumerate tuples
        #
        # @return [self]
        #   returns self if block given
        #
        # @return [Enumerator]
        #   returns Enumerator if no block given
        #
        # @api private
        #
        def each(&block)
          return to_enum(__method__) unless block_given?

          documents.each do |document|
            yield tuple(document)
          end

          self
        end

      private

        # Initialize a mongo query
        #
        # @param [Mongo::DB] database
        # @param [Relation] relation
        #
        # @return [undefined]
        #
        # @api private
        #
        def initialize(database, relation)
          @visitor    = Visitor.new(relation)
          @collection = database.collection(@visitor.collection_name)
        end

        # Return document fields
        #
        # @return [Array<String>]
        #
        # @api private
        #
        def fields
          @visitor.fields.map(&:to_s)
        end

        # Return results enumerator
        #
        # @return [Enumerator<Hash>]
        #
        # @api private
        #
        def documents
          @collection.find(@visitor.query, @visitor.options)
        end

        # Create array tuple from document
        #
        # @return [Array]
        #
        # @api private
        #
        def tuple(document)
          fields.each_with_object([]) do |field, tuple|
            tuple << document[field]
          end
        end

        memoize :fields
      end
    end
  end
end
