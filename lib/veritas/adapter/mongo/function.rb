module Veritas
  module Adapter
    class Mongo
      # Module to transform veritas functions into mongo literals
      module Function

        FUNCTIONS = Operations.new(
          Veritas::Function::Predicate::Equality             => :equality_predicate,
          Veritas::Function::Predicate::Inequality           => :inequality_predicate,
          Veritas::Function::Predicate::Inclusion            => :inclusion_predicate,
          Veritas::Function::Predicate::Exclusion            => :exclusion_predicate,
          Veritas::Function::Predicate::GreaterThan          => :greater_than_predicate,
          Veritas::Function::Predicate::GreaterThanOrEqualTo => :greater_than_or_equal_to_predicate,
          Veritas::Function::Predicate::LessThan             => :less_than_predicate,
          Veritas::Function::Predicate::LessThanOrEqualTo    => :less_than_or_equal_to_predicate,
          Veritas::Function::Connective::Disjunction         => :disjunction, 
          Veritas::Function::Connective::Conjunction         => :conjunction, 
          Veritas::Function::Connective::Negation            => :negation
        )

        # Create function literal
        #
        # @param [Function] function
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.function(function)
          send(*FUNCTIONS.lookup(function))
        end

        # Create disjunction literal
        #
        # @param [Function::Predicate::Disjunction] disjunction
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.disjunction(disjunction)
          create_connective(disjunction,:$or)
        end
        private_class_method :disjunction

        # Create conjunction literal
        #
        # @param [Function::Predicate::Disjunction] conjunction
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.conjunction(conjunction)
          create_connective(conjunction,:$and)
        end
        private_class_method :conjunction

        # Create connective literal
        #
        # @param [Function::Connective] connective
        # @param [Symbol] operator
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.create_connective(connective,operator)
          { operator => [function(connective.left),function(connective.right)] }
        end
        private_class_method :create_connective

        # Create equality predicate literal
        #
        # @param [Function::Predicate::Equality] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.equality_predicate(predicate)
          { Literal.attribute_name(predicate.left) => Literal.primitive(predicate.right) }
        end
        private_class_method :equality_predicate

        # Create inequality predicate literal
        #
        # @param [Function::Predicate::Inequality] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.inequality_predicate(predicate)
          predicate(predicate,:$ne)
        end
        private_class_method :inequality_predicate

        # Create inclusion predicate literal
        #
        # @param [Function::Predicate::Inclusion] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.inclusion_predicate(predicate)
          predicate(predicate,:$in)
        end
        private_class_method :inclusion_predicate

        # Create exclusion predicate literal
        #
        # @param [Function::Predicate::Inclusion] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.exclusion_predicate(predicate)
          predicate(predicate,:$nin)
        end
        private_class_method :exclusion_predicate

        # Create less than predicate literal
        #
        # @param [Function::Predicate::LessThan] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.less_than_predicate(predicate)
          predicate(predicate,:$lt)
        end
        private_class_method :less_than_predicate

        # Create less than or equal to predicate literal
        #
        # @param [Function::Predicate::LessThanOrEqualTo] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.less_than_or_equal_to_predicate(predicate)
          predicate(predicate,:$lte)
        end
        private_class_method :less_than_or_equal_to_predicate

        # Create greater than predicate literal
        #
        # @param [Function::Predicate::GreaterThan] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.greater_than_predicate(predicate)
          predicate(predicate,:$gt)
        end
        private_class_method :greater_than_predicate

        # Create greatehr than or equal to literal
        #
        # @param [Function::Predicate::GreaterThanOrEqualTo] predicate
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.greater_than_or_equal_to_predicate(predicate)
          predicate(predicate,:$gte)
        end
        private_class_method :greater_than_or_equal_to_predicate

        # Create negation literal
        #
        # @param [Function] function
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.negation(function)
          { :$not => function(function.inverse) }
        end
        private_class_method :negation

        # Create generic predicate literal
        #
        # @param [Function::Predicate] predicate
        # @param [Symbol] operator
        #
        # @return [Hash]
        #
        # @api private
        #
        def self.predicate(predicate,operator)
          { Literal.attribute_name(predicate.left) => { operator => Literal.primitive(predicate.right) } }
        end
        private_class_method :predicate
      end
    end
  end
end
