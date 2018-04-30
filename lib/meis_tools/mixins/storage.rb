module Meis::Storage
  # We'll use YAML by default, instead of PStore, so that data files will be
  # human-readable and editable.
  #
  # See http://yaml.org/ for more info
  # @note all `key`s will be converted to symbols
  #
  module Yaml
    # Save value by key to a storage bin
    #
    # @param key [String, Symbol] Key
    # @param value [Object] Value
    # @param data_store [YAML::Store] Storage
    def store(key, value = nil, data_store = nil)
      data_store.transaction do
        data_store[key.to_sym] = value
      end
    end

    # Retrieve value by key from a storage bin
    #
    # @param key [String, Symbol] Key
    # @param data_store [YAML::Store] Storage
    # @param default [Object] Default value when key not initialized
    def restore(key, data_store = nil, default = nil)
      data_store.transaction do
        data_store[key.to_sym] || default
      end
    end

    # (Create and)? Open a storage bin
    #
    # @param file_path [String] Path to storage file
    # @return [YAML::Store] Storage
    def open_store(file_path)
      YAML::Store.new(file_path)
    end
  end
end
