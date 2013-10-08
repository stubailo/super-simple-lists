class List < ActiveRecord::Base
  has_many :notes

  # having a separate relation for each kind of permission makes it easy to check and set permissions
  has_many :list_permissions
  has_many :list_ownerships, -> {where :level => "owner"}, :class_name => "ListPermission"
  has_many :list_edit_permissions, -> {where :level => "edit"}, :class_name => "ListPermission"
  has_many :list_read_permissions, -> {where :level => "read"}, :class_name => "ListPermission"

  # the relations below let us do stuff like list.owners << user to add an owner to a list
  # or list.owners.delete user to get rid of the owner, or list.owners.include? user
  # to check permissions
  has_many :users, :through => :list_permissions
  has_many :owners, :through => :list_ownerships, :class_name => "User", :source => :user
  has_many :editors, :through => :list_edit_permissions, :class_name => "User", :source => :user
  has_many :readers, :through => :list_read_permissions, :class_name => "User", :source => :user
end
