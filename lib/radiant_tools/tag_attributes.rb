module RadiantTools::TagAttributes
  def self.init
    Radius::TagBinding.class_eval do
      def initialize(context, locals, name, attributes, block)
        @context, @locals, @name, @attributes, @block = context, locals, name, HashWithIndifferentAccess.new(attributes), block
      end
    end
  end
end