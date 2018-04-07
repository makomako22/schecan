class StudentsController < ApplicationController

  def index
    @students = Student.order('term DESC').order('family_name_kana ASC').page(params[:page]).per(10)
  end

  def show
    @student = Student.find(params[:id])
    @schedules = Schedule.where(student_id: @student.id).order('schedule_at ASC').page(params[:page]).per(10)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to student_path, notice: "登録が完了しました"
    else
      render :new, alert: "必須項目を入力してください"
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    student = Student.find(params[:id])
    @student = Student.find(params[:id])
    if student.update(student_params)
    redirect_to student_path(student.id), notice: "編集が完了しました"
    else
      redirect_to :back, alert: "必須項目を入力してください"
    end
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    redirect_to :back, notice: "削除が完了しました"
  end

  def search
    @students = Student.where('family_name LIKE(?)', "%#{params[:keyword]}%").page(params[:page]).per(10)
  end

  private

  def student_params
    params.require(:student).permit(:term, :family_name, :first_name, :family_name_kana, :first_name_kana, :sheet, :detail)
  end

end
