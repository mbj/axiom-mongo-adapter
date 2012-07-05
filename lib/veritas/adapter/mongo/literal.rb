module Veritas
  module Adapter
    class Mongo
      # Component to check for valid bson literals
      module Literal
        # Return attribute name as key
        #
        # @param [Attribute] attribute
        #
        # @return [Symbol]
        #
        # @api private
        #
        def self.attribute_name(attribute)
          key(attribute.name)
        end

        # Return sort literal
        #
        # @param [Relation::Operation::Order::DirectionSet] directions
        #
        # @return [Array]
        #
        # @api private
        #
        def self.sort(directions)
          directions.map do |direction|
            [direction.name,direction(direction)]
          end
        end

        # Check value is a valid bson primitive
        #
        # @param [Object] value
        #
        # @return [Object]
        #
        # @api private
        #
        def self.primitive(value)
          case value
          when Integer,String,Float
          when Array
            value.each { |element| primitive(element) }
          else
            raise ArgumentError,"Not a supported primitive #{value.inspect}"
          end

          value
        end

        # Return sort direction
        #
        # @param [Relation::Operation::Order::Direction] direction
        #
        # @return [Mongo::ASCENDING]
        # @return [Mongo::DESCENDING]
        #
        # @api private
        #
        def self.direction(direction)
          if direction.is_a?(Relation::Operation::Order::Descending)
            ::Mongo::DESCENDING
          else
            ::Mongo::ASCENDING
          end
        end
        private_class_method :direction

        # Check value is a valid bson key
        #
        # @param [Object] value
        #
        # @return [Object]
        #
        # @api private
        #
        def self.key(value)
          case value
          when Symbol,String
          else
            raise ArgumentError,"Not a supported key #{value.inspect}"
          end

          value
        end
        private_class_method :key
      end
    end
  end
end
