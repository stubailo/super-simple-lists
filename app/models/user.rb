class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :list_permissions
  has_many :list_ownerships, -> {where :level => "owner"}, :class_name => "ListPermission"
  has_many :list_edit_permissions, -> {where :level => "edit"}, :class_name => "ListPermission"

  has_many :lists, :through => :list_permissions
  has_many :owned_lists, :through => :list_ownerships, :class_name => "List", :source => :list
  has_many :editable_lists, :through => :list_edit_permissions, :class_name => "List", :source => :list
end
