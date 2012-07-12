# encoding: utf-8

module Veritas
  module Adapter
    class Mongo
      # A relation backed by mongo adapter
      class Gateway < ::Veritas::Relation

        DECORATED_CLASS = superclass

        # Poor man forwardable for now.
        (DECORATED_CLASS.public_instance_methods(false).map(&:to_s) - %w[ materialize one ]).each do |method|
          class_eval(<<-RUBY, __FILE__,__LINE__+1)
            def #{method}(*args, &block)
              relation.public_send(:#{method}, *args,&block)
            end
          RUBY
        end

        # Return inspected stub to fight against inspect related errors in spec printouts
        #
        # @return [String]
        #
        # @api private
        #
        # TODO: Remove this.
        #
        def inspect; 'GATEWAY'; end

        MAP = [
          Relation::Operation::Order,
          Relation::Operation::Offset,
          Relation::Operation::Limit,
          Algebra::Restriction
        ].each_with_object({}) do |operation, map|
          operation::Methods.public_instance_methods(false).each do |method|
            method = method.to_sym
            next if method == :last
            map[method.to_sym]=operation
          end
        end

        MAP.each_key do |method|
          class_eval(<<-RUBY, __FILE__,__LINE__+1)
            def #{method}(*args, &block)
              unless supported?(:#{method})
                return super
              end

              response = @relation.send(:#{method}, *args,&block)
              self.class.new(adapter, response, @operations + [response.class])
            end
          RUBY
        end

        # The adapter the gateway will use to fetch results
        #
        # @return [Adapter::Mongo]
        #
        # @api private
        #
        attr_reader :adapter
        protected :adapter

        # The relation the gateway will use to generate Query
        #
        # @return [Relation]
        #
        # @api private
        #
        attr_reader :relation
        protected :relation

        # Initialize a Gateway
        #
        # @param [Adapter::DataObjects] adapter
        #
        # @param [Relation] relation
        #
        # @return [undefined]
        #
        # @api private
        #
        def initialize(adapter, relation, operations=Set.new)
          @adapter  = adapter
          @relation = relation
          @operations = operations
        end

        # Iterate over each row in the results
        #
        # @example
        #   gateway = Gateway.new(adapter, relation)
        #   gateway.each { |tuple| ... }
        #
        # @yield [tuple]
        #
        # @yieldparam [Tuple] tuple
        #   each tuple in the results
        #
        # @return [self]
        #
        # @api public
        #
        def each
          return to_enum unless block_given?
          tuples.each { |tuple| yield tuple }
          self
        end

      private

        # Return if method is supported in this gateway
        #
        # @param [Symbol] method
        #
        # @return [true|false]
        #
        # @api private
        #
        def supported?(method)
          !@operations.include?(MAP.fetch(method))
        end

        # Return a list of tuples to iterate over
        #
        # @return [#each]
        #
        # @api private
        #
        def tuples
          relation = self.relation

          return relation if materialized?

          DECORATED_CLASS.new(header, adapter.read(relation))
        end
      end
    end # class Gateway
  end # class Relation
end # module Veritas
