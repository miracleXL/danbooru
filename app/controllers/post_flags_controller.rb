class PostFlagsController < ApplicationController
  before_filter :member_only
  respond_to :html, :xml, :json, :js
  rescue_from User::PrivilegeError, :with => "static/access_denied"

  def new
    @post_flag = PostFlag.new
    respond_with(@post_flag)
  end
  
  def index
    @search = PostFlag.search(params[:search])
    @post_flags = @search.paginate(:page => params[:page])
  end
  
  def create
    @post_flag = PostFlag.create(params[:post_flag])
    respond_with(@post_flag)
  end

private
  def check_privilege(post_flag)
    raise User::PrivilegeError unless (post_flag.creator_id == CurrentUser.id || CurrentUser.is_moderator?)
  end
end
