class BasesController < ApplicationController

  def show
    @students = Student.where(base_id: params[:id]).order('term DESC').order('family_name_kana ASC').page(params[:page]).per(10)
    @base = Base.find_by(id: params[:id])
  end

  def new
    @base = Base.find(params[:base_id])
  end

  def update
    @base = Base.find(params[:id])
    if @base.update(base_params)
      redirect_to schedules_path(base_id: @base.id), notice: "登録が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :new
    end
  end

  private
  def base_params
    params.require(:base).permit(:memo_h, :memo)
  end

end
