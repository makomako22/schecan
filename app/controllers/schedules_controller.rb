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
      redirect_to root_path, notice: "登録が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :new
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    schedule = Schedule.find(params[:id])
    @schedule = Schedule.find(params[:id])
    if schedule.update(schedule_params)
      redirect_to root_path, notice: "変更が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :edit
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    redirect_to root_path, notice: "削除が完了しました"
  end

  private

  def schedule_params
    params.require(:schedule).permit(Schedule::REGISTRABLE_ATTRIBUTES, :mentor, :memo, :student_id, :checkbox)
  end

end
