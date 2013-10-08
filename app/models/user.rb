class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # different relations for each kind of permission to enable really easy permission checking, adding and removal
  has_many :list_permissions
  has_many :list_ownerships, -> {where :level => "owner"}, :class_name => "ListPermission"
  has_many :list_edit_permissions, -> {where :level => "edit"}, :class_name => "ListPermission"

  # the code below lets us do stuff like User.first.owned_lists << List.first to set permissions
  has_many :lists, :through => :list_permissions
  has_many :owned_lists, :through => :list_ownerships, :class_name => "List", :source => :list
  has_many :editable_lists, :through => :list_edit_permissions, :class_name => "List", :source => :list
end
