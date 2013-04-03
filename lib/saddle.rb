require 'saddle/method_tree_builder'
require 'saddle/requester'

require 'saddle/middleware/ruby_timeout'



module Saddle

  class Client

    extend MethodTreeBuilder


    def self.create(opt={})
      requester = Saddle::Requester.new(
        default_options.merge(opt)
      )
      self.build_tree(requester)
    end

    # Options are passed down to the Requester.
    # See saddle/requester.rb for available options.
    def initialize(opt={})
      @requester = Requester.new(
        default_options.merge(opt)
      )
      if knows_root?
        attach_endpoint_tree
      end
    end


    ### OVERRIDE THIS IF YOU WANT!
    #
    # Override this to add default initialize options to a concrete implementation
    #
    # Note: You must also override this if you want endpoint support
    #
    # ex:
    #
    #  def self.default_options
    #    {
    #      :host => 'example.org',
    #      :port => 8080,
    #    }
    #  end
    #
    ###
    def self.default_options
      {
        :addtional_middleware => self.default_middleware,
      }
    end


    ### OVERRIDE THIS IF YOU WANT!
    #
    # Override this to add additional middleware to the request stack
    # ex:
    #
    # require 'my_middleware'
    # def self.default_middleware
    #   [MyMiddleware]
    # end
    #
    ###
    def self.default_middleware
      [
        {:klass => Saddle::Middleware::RubyTimeout},
      ]
    end



    def self.inherited(obj)
      path, = caller[0].partition(":")
      @@implementation_root = File.dirname(path)
    end

    def self.implementation_root
      @@implementation_root
    end

    def knows_root?
      defined?(@@implementation_root)
    end

  end

end
