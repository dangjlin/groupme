class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :groups
  has_many :posts


  # many to many associatation . 
  # use group_user model to connect both user and group model . 

  has_many :group_users
  has_many :participated_groups, :through => :group_users, :source => :group

  # participated_groups 是被換掉的一個 model ,  換掉什麼呢?  
  # 本來應該可以只要用  " has_many :groups :through  => :group_users " 就好了 
  # 但是因為我們在 controller & view 那邊需要使用到  participated_groups 這個 class 所以就換掉了  
  # 但是換掉之後 rails 沒辦法到 group_user 的 model 裡面去找到  participated_group 的 關聯性 
  # 所以要用 :source => :group 跟 rails 說去看看 有沒有  group 的關聯性是什麼 , 
  # 這樣 rails 就會在  group_user model 裡面去看到 有  belongs_to group 這個 關聯性了... 



  extend OmniauthCallbacks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    
  def join!(group)
    participated_groups << group
  end


  def quit!(group)
    participated_groups.delete(group)
  end

  def is_member_of?(group)
    participated_groups.include?(group)
  end


# facebook authentication callback 
  def self.find_for_facebook_oauth(auth)
    user = User.where(provider: auth.provider, fb_id: auth.uid).first

    unless user
      user = User.create( name:     auth.extra.raw_info.name,
                          provider: auth.provider,
                          fb_id:      auth.uid,
                          email:    auth.info.email,
                          token:    auth.credentials.token,
                          password: Devise.friendly_token[0,20] )
    end

    return user
  end

end
