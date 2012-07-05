module Veritas
  module Adapter
    class Mongo
      # Mongo visitor for veritas relations
      class Visitor
        include Immutable

        # Return query
        #
        # @return [Hash]
        #
        # @api private
        #
        attr_reader :query

        # Return collection name
        #
        # @return [String]
        #
        # @api private
        #
        attr_reader :collection_name

        # Return fields to select
        #
        # @return [Array<Symbol>]
        #
        # @api private
        #
        attr_reader :fields

        # Return sort directions
        #
        # @return [Array<Symbol>]
        #
        # @api private
        #
        attr_reader :sort

      private

        # Initialize visitor
        #
        # @param [Relation] relation
        #
        # @return [undefined]
        #
        # @api private
        #
        def initialize(relation)
          @query,@sort    = {},[]
          dispatch(relation)
        end

        TABLE = Operations.new(
          Veritas::Relation::Base              => :visit_base_relation,
          Veritas::Relation::Operation::Order  => :visit_order_operation,
          Veritas::Algebra::Restriction        => :visit_restriction
        )

        # Dispatch relation
        #
        # @param [Relation] relation
        #
        # @return [self]
        #
        # @api private
        #
        def dispatch(relation)
          call = TABLE.lookup(relation)
          send(*call)

          self
        end

        # Visit a base relation
        #
        # @param [Relation::Base] base_relation
        #
        # @return [self]
        #
        # @api private
        #
        def visit_base_relation(base_relation)
          @collection_name = base_relation.name
          @fields          = base_relation.header.map(&:name)

          self
        end

        # Visit a restriction
        #
        # @param [Algebra::Restriction] restriction
        #
        # @return [self]
        #
        # @api private
        #
        def visit_restriction(restriction)
          @query = Function.function(restriction.predicate)
          dispatch(restriction.operand)

          self
        end

        # Vist an order operation
        #
        # @param [Relation::Operation::Order] order
        #
        # @return [self]
        #
        # @api private
        #
        def visit_order_operation(order)
          @sort = Literal.sort(order.directions)
          dispatch(order.operand)

          self
        end
      end
    end
  end
end
