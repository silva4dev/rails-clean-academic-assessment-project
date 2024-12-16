module SharedKernel
  module Infrastructure
    class Mapper
      def self.to_entity(dao)
        raise NotImplementedError
      end

      def self.to_dao(entity)
        raise NotImplementedError
      end
    end
  end
end
