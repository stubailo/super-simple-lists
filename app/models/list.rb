class List < ActiveRecord::Base
  has_many :notes

  has_many :list_permissions
  has_many :list_ownerships, -> {where :level => "owner"}, :class_name => "ListPermission"
  has_many :list_edit_permissions, -> {where :level => "edit"}, :class_name => "ListPermission"
  has_many :list_read_permissions, -> {where :level => "read"}, :class_name => "ListPermission"

  has_many :users, :through => :list_permissions
  has_many :owners, :through => :list_ownerships, :class_name => "User", :source => :user
  has_many :editors, :through => :list_edit_permissions, :class_name => "User", :source => :user
  has_many :readers, :through => :list_read_permissions, :class_name => "User", :source => :user
end
