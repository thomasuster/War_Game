require 'rubygems'
require 'uuidtools'

#http://ariejan.net/2008/08/12/ruby-on-rails-uuid-as-your-activerecord-primary-key/
#http://stackoverflow.com/questions/2487837/uuids-in-rails3
module UUIDHelper
  def self.included(base)
    base.class_eval do
      before_create :set_uuid

      def set_uuid
        self.uuid = UUIDTools::UUID.timestamp_create().to_s
      end
    end
  end
end