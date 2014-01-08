class PostsController < ApplicationController

before_action :find_group


 def new
    @group = Group.find(params[:group_id])
    @post = @group.posts.build
 end



private

def find_group
    @group = Group.find(params[:group_id])
end


end
