class StudentsController < ApplicationController
  before_action :edit_password
  def index
    @students = Student.includes(:base).order('term DESC').order('family_name_kana ASC').page(params[:page]).per(10)
    @student = Student.find_by(base_id: params[:base_id])
  end

  def show
    @student = Student.includes(:base).find(params[:id])
    @schedules = Schedule.where(student_id: @student.id).order('schedule_at ASC').page(params[:page]).per(10)
  end

  def new
    @student = Student.new
    @student.term = params[:term]
    @student.base_id = params[:base_id]
    @terms = Term.order('term_i ASC')
    @bases = Base.all
  end

  def create
    @student = Student.new(student_params)
    @terms = Term.all
    @bases = Base.all
    if @student.save
      redirect_to basis_path(@student.base_id), notice: "登録が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
    @terms = Term.order('term_i ASC')
    @bases = Base.all
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to @student, notice: "編集が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :edit
    end
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    redirect_to basis_path(student.base_id), notice: "削除が完了しました"
  end

  def search
    if params[:keyword].present?
      @students = Student.where('family_name LIKE(?)', "%#{params[:keyword]}%").page(params[:page]).per(10)
    end
  end

  private

  def student_params
    params.require(:student).permit(:base_id, :term, :family_name, :first_name, :family_name_kana, :first_name_kana, :sheet, :detail)
  end

end
