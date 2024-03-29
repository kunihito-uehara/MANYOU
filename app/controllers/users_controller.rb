class UsersController < ApplicationController
  skip_before_action :login_required, only: [ :new, :create ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :new_user_create, only: [ :new ]
  before_action :other_user, only: [ :show, :edit, :update, :destroy ]
  
  def new
    @user = User.new
  end

  def create
    #登録フォームに記入した後、ユーザーに登録とログインを強制
    #登録後、ユーザーがログインページにリダイレクトされない
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def show
    #@user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def destroy
    if @user.destroy
      redirect_to new_user_path, notice: "ユーザーを削除！"
    else
      redirect_to admin_users_path, notice: "管理者が１人以上必要のため削除できません！！！"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def new_user_create
    redirect_to user_path(current_user.id), notice:"ログアウト後新規登録してください" if logged_in?
  end

  def other_user
    unless current_user.id == params[:id].to_i
      flash[:notice] = "権限がありません！"
      redirect_to tasks_path
    end
  end
end
