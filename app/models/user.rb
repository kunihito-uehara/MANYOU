class User < ApplicationRecord
  has_many :tasks, dependent: :destroy #退会（削除）したユーザに紐づく全投稿が削除される。
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password,length: { minimum: 6 }

  before_destroy :last_admin_exist_check
  before_update :last_admin_exist_check_update

  def last_admin_exist_check
    throw :abort if self.admin? && User.where(admin: true).count == 1
  end
  #User.where(admin: true).count == 1 #admin権限を持つユーザーが残り1人である時
  #&& self.admin == false
  #かつ、そのユーザーの権限が外されるような処理の時
  #throw(:abort)で処理を中断
  def last_admin_exist_check_update
    @admin_user = User.where(admin: true)
    throw :abort if @admin_user.first == self && @admin_user.count == 1
  end
end


# after_destroy コード例
# def one_admin_user_at_least_update
#     if User.where(admin: true).count ==0
#       errors.add(:user, 'には少なくとも１名のadmin権限者が必要です。')
#       raise ActiveRecord::RecordInvalid, self

# after_destroyなので、User.where(admin: true).count ==0になってしまうような処理が起きた時にエラーを発生させる。
# バリデーションのエラーをraiseで発生させる。