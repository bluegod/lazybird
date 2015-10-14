module Lazybird
  module Utils
    module Hash
      def self.find_by_key(hash, key)
        hash.select { |k, h| k == key }
      end

      def self.compact(hash)
        hash.select { |_, v| v }
      end

      def self.array_to_hash(keys, values)
        ::Hash[[keys, values].transpose]
      end
    end
  end
end