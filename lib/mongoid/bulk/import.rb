require "mongoid/bulk/import/version"
require 'mongoid'

module Mongoid
  module Bulk
    module Import			
			extend ActiveSupport::Concern
      Result = Struct.new(:failed_instances, :num_inserts, :ids)
			
			def bulk_insert(attributes = nil, options = {}, &block)
	      _creating do
          if attributes.is_a?(::Array)
            documents = attributes.map { |attrs| bulk_insert_obj(attrs, options, &block) }
          else
            documents = [bulk_insert_obj(attributes, options, &block)]
          end
          valid_documents, invalid_documents = documents.partition { |doc| doc.errors.none? }
          response = collection.insert_many(valid_documents.map(&:as_document)) unless valid_documents.blank?
          Result.new(invalid_documents, response&.inserted_count || 0, response&.inserted_ids || [])
        end
      end

      def bulk_insert_obj(attributes = nil, options = {}, &block)
        doc = new(attributes, &block)
        doc.valid? if (options[:validate].nil? ? true : options[:validate])
        doc 
      end
	  end
  end
end
Mongoid::Document::ClassMethods.send(:include, Mongoid::Bulk::Import)
