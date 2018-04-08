class SchedulesController < ApplicationController

  def index
    @today = DateTime.now.beginning_of_day + 9.hour
    afterDay = @today + 1.day
    @today_schedules = Schedule.includes(:student).where("schedule_at >= ?", @today).where("schedule_at < ?", afterDay).order('schedule_at ASC').page(params[:page]).per(10)
    @undo_schedules = Schedule.includes(:student).where("schedule_at < ?", @today).where(checkbox: 0).order('schedule_at ASC').page(params[:page]).per(10)
    @schedules = Schedule.includes(:student).where("schedule_at >= ?", afterDay).order('schedule_at ASC')
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @student = Student.find(params[:student_id])
    @schedule = Schedule.new
    @schedule.student_id = @student.id
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.checkbox = 0
    if @schedule.save
      flash.now[:notice] = "登録が完了しました"
      redirect_to root_path
    else
      flash.now[:alert] = "同じ日時がすでに登録されているか、必須項目が入力されていません"
      render :new
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    schedule = Schedule.find(params[:id])
    if schedule.update(schedule_params)
      flash.now[:notice] = "変更が完了しました"
      redirect_to root_path
    else
      flash.now[:alert] = "同じ日時がすでに登録されているか、必須項目が入力されていません"
      redirect_to :back
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    flash.now[:notice] = "削除が完了しました"
    redirect_to root_path
  end

  private

  def schedule_params
    params.require(:schedule).permit(:schedule_at, :mentor, :memo, :student_id, :checkbox)
  end

end
