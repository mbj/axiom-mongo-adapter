require 'mongo'
require 'veritas'

module Veritas
  module Adapter
    # An adapter for mongodb
    class Mongo
      # Error raised when query on unsupported algebra is created
      class UnsupportedAlgebraError < StandardError; end

      include Immutable

    end
  end
end

require 'veritas/adapter/mongo/gateway'
