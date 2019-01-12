class SchedulesController < ApplicationController
   before_action :edit_password
  def index
    @today = DateTime.now.beginning_of_day
    @afterDay = @today + 1.day
    dayAfterTomorrow = @afterDay + 1.day
    if params[:base_id].present?
      @memo = Base.find(params[:base_id])
      @today_schedules = Schedule.includes(:student).where(base_id: params[:base_id]).where("schedule_at >= ?", @today).where("schedule_at < ?", @afterDay).order('schedule_at ASC')
      @tommorow_schedules = Schedule.includes(:student).where(base_id: params[:base_id]).where("schedule_at >= ?", @afterDay).where("schedule_at < ?", dayAfterTomorrow).order('schedule_at ASC')
      @undo_schedules = Schedule.includes(:student).where(base_id: params[:base_id]).where("schedule_at < ?", @today).where(checkbox: 0).order('schedule_at ASC')  
      @schedules = Schedule.includes(:student).where(base_id: params[:base_id]).where("schedule_at >= ?", @afterDay).order('schedule_at ASC')
      @today_briefings = Briefing.where(base_id: params[:base_id]).where("schedule_at >= ?", @today).where("schedule_at < ?", @afterDay).order('schedule_at ASC')
      @tommorow_briefings = Briefing.where(base_id: params[:base_id]).where("schedule_at >= ?", @afterDay).where("schedule_at < ?", dayAfterTomorrow).order('schedule_at ASC')
      @briefings = Briefing.where(base_id: params[:base_id]).where("schedule_at >= ?", @afterDay).order('schedule_at ASC')
    else
      @today_schedules = Schedule.includes(:student).where("schedule_at >= ?", @today).where("schedule_at < ?", @afterDay).order('base_id ASC').order('schedule_at ASC')
      @tommorow_schedules = Schedule.includes(:student).where("schedule_at >= ?", @afterDay).where("schedule_at < ?", dayAfterTomorrow).order('base_id ASC').order('schedule_at ASC')
      @undo_schedules = Schedule.includes(:student).where("schedule_at < ?", @today).where(checkbox: 0).order('schedule_at ASC')  
      @schedules = Schedule.includes(:student).where("schedule_at >= ?", @afterDay).order('schedule_at ASC')
      @today_briefings = Briefing.where("schedule_at >= ?", @today).where("schedule_at < ?", @afterDay).order('schedule_at ASC')
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @student = Student.find(params[:student_id])
    @schedule = Schedule.new
    @schedule.student_id = @student.id
    @schedule.base_id = @student.base_id
  end

  def create
    @student = Student.find(params[:schedule][:student_id])
    @schedule = Schedule.new(schedule_params)
    @schedule.checkbox = 0
    if @schedule.save
      redirect_to schedules_path(base_id: @schedule.base_id), notice: "登録が完了しました"
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
    if schedule.update(schedule_params)
      redirect_to schedules_path(base_id: schedule.base_id), notice: "変更が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :edit
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    redirect_to schedules_path(base_id: schedule.base_id), notice: "削除が完了しました"
  end

  def use
  end

  private

  def schedule_params
    params.require(:schedule).permit(Schedule::REGISTRABLE_ATTRIBUTES,:base_id, :mentor, :memo, :student_id, :checkbox)
  end

end
