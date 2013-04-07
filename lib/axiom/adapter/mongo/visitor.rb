module Axiom
  module Adapter
    class Mongo
      # Mongo visitor for axiom relations
      class Visitor
        include Adamantium::Flat

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

        # Return mongo query options
        #
        # @return [Hash]
        #
        # @api private
        #
        def options
          {
            :skip   => @skip,
            :limit  => @limit,
            :sort   => @sort,
            :fields => fields
          }
        end

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
          dispatch(relation)
          @query ||= {}
          @sort  ||= []
        end

        TABLE = Operations.new(
          Axiom::Relation::Base              => :visit_base_relation,
          Axiom::Relation::Operation::Order  => :visit_order_operation,
          Axiom::Relation::Operation::Limit  => :visit_limit_operation,
          Axiom::Relation::Operation::Offset => :visit_offset_operation,
          Axiom::Algebra::Restriction        => :visit_restriction
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
          assign_first_time(:@query, restriction) do
            Function.function(restriction.predicate)
          end
        end

        # Assign component for the first time
        #
        # @param [Symbol] ivar_name
        # @param [Axiom::Relation::Operation] operation
        #
        # @return [self]
        #
        # @api private
        #
        def assign_first_time(ivar_name, operation)
          if instance_variable_get(ivar_name)
            raise UnsupportedAlgebraError, "No support for visiting #{operation.class} more than once"
          end

          instance_variable_set(ivar_name, yield)

          dispatch(operation.operand)

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
          assign_first_time(:@sort, order) do
            Literal.sort(order.directions)
          end
        end

        # Vist a limit operation
        #
        # @param [Relation::Operation::Limit] limit
        #
        # @return [self]
        #
        # @api private
        #
        def visit_limit_operation(limit)
          assign_first_time(:@limit, limit) do
            Literal.positive_integer(limit.limit)
          end
        end

        # Vist an offset operation
        #
        # @param [Relation::Operation::Offset] offset
        #
        # @return [self]
        #
        # @api private
        #
        def visit_offset_operation(offset)
          assign_first_time(:@skip, offset) do
            Literal.positive_integer(offset.offset)
          end
        end

        memoize :options
      end
    end
  end
end
