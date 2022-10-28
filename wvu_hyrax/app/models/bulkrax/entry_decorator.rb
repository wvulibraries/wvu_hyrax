module Bulkrax
    module EntryDecorator
      def factory_class
        GenericWork
      end
    end
  end
  Bulkrax::Entry.prepend Bulkrax::EntryDecorator
  