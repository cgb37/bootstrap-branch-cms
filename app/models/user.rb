class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles

  ROLES = %w[member author moderator administrator]



  def has_role?(requested_role)
    return false unless role # A user have a role attribute. If not set, the user does not have any roles.
    ROLES.index(requested_role.to_s) <= ROLES.index(role)
  end
end
