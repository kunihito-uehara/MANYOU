class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy]
  
    def index
    #@tasks = Task.all.order(created_at: :desc)
    #pageとperメソッドがkaminariで定義されたメソッド
    #perメソッドの引数にどれだけのレコードが表示されたらページを増やすかを指定できる。
    if params[:sort_expired]
      #@tasks = Task.all.page(params[:page]).per(5).expired
      @tasks = current_user.tasks.all.page(params[:page]).per(5).expired

    elsif params[:sort_priority]
      #@tasks = Task.all.page(params[:page]).per(5).priority
      @tasks = current_user.tasks.all.page(params[:page]).per(5).priority
    else
      @tasks = current_user.tasks.page(params[:page]).per(5).latest
      #@tasks = current_user.tasks.all       
      #@tasks = @tasks.page(params[:page]).per(5)     
    end
    if params[:search_name].present? && params[:search_status].present?
      @tasks = current_user.tasks.search_title(params[:search_name]).search_status(params[:search_status]).page(params[:page]).per(5)
    elsif params[:search_name].present?
      @tasks = current_user.tasks.search_title(params[:search_name]).page(params[:page]).per(5)
    elsif params[:search_status].present?
      @tasks = current_user.tasks.search_status(params[:search_status]).page(params[:page]).per(5)
    #  @tasks = Task.all.search_title(params[:search_title]).search_status(params[:search_status]).page(params[:page]).per(5)
    end
  end

    def show
        #@task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end

    def create
        # @task = Task.new(task_params)
        # @task.user_id = current_user.id
        @task = current_user.tasks.build(task_params)

    if @task.save
        redirect_to tasks_path, notice: "タスク投稿！"
        else
        render :new
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        @task.update(task_params)
        redirect_to tasks_path, notice: "編集しました！"
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_path, notice: "削除しました！"   
    end

    private

    def task_params
    params.require(:task).permit(:title, :content,:expiration_date, :status, :priority)
    end
    def set_task
    @task = Task.find(params[:id])
    end
end
