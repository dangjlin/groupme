class Group < ActiveRecord::Base


  has_many :posts
  validates :title, :presence => true
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id

  has_many :group_users
  has_many :members, :through => :group_users, :source => :user


  # after creator created group , auto add the creator to group_owner  
  # this is ActiveRecord 的 回呼 callbacks 的 methods . 用來在rails 準備讓資料對資料庫做動作前後的預先/接續 動作 

  after_create :join_owner_to_group 




  def editable_by?(user)
    user && user == owner
  end

  def join_owner_to_group
	members << owner
  end

end
