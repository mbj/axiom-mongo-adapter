require 'spec_helper'
require 'logger'

# if ENV['TRAVIS'] or ENV['HAS_MONGO']
  describe Adapter::Mongo, 'insert' do
    let(:uri)           { ENV.fetch('MONGO_URI', '127.0.0.1')                                    }
    let(:logger)        { Logger.new($stdout)                                                    }
            
    let(:adapter)       { Adapter::Mongo.new(database)                                           }
    let(:base_relation) { Relation::Base.new('people', [[:firstname,String],[:lastname,String]]) }

    let(:connection)    { Mongo::Connection.new(uri)                                             }
                                                                                    
    let(:relation)      { Adapter::Mongo::Gateway.new(adapter, base_relation)                    }
    let(:database)      { connection.db('test')                                                  }
    let(:collection)    { database.collection('people')                                          }


    after :all do
      collection.remove
    end

    specify 'it allows to insert new records to empty relation' do
      collection.remove
      data = relation.insert([[ 'John', 'Doe' ],[ 'Sue', 'Doe' ]])
      relation.to_ary.should == [
        [ 'John', 'Doe' ],
        [ 'Sue', 'Doe' ]
      ]
    end

    specify 'it allows to insert new record to existing relation' do
      collection.remove
      data = relation.insert([[ 'John', 'Doe' ],[ 'Sue', 'Doe' ]])
      data = relation.insert([[ 'Tray', 'Doe' ]])
      relation.to_ary.should == [
        [ 'John', 'Doe' ],
        [ 'Sue', 'Doe' ],
        [ 'Tray', 'Doe' ]
      ]
    end

  end
# end