class BriefingsController < ApplicationController
	def new
    @briefing = Briefing.new
    @bases = Base.all
  end

  def create
  	@briefing = Briefing.new(briefing_params)
    if @briefing.save
      redirect_to schedules_path(base_id: @briefing.base_id), notice: "登録が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :new
    end
  end

  def edit
    @briefing = Briefing.find(params[:id])
    @bases = Base.all
  end

  def update
  	@briefing = Briefing.find(params[:id])
  	if @briefing.update(briefing_params)
      redirect_to schedules_path(base_id: @briefing.base_id), notice: "変更が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :edit
    end
  end

  def destroy
  	briefing = Briefing.find(params[:id])
  	briefing.destroy
  	redirect_to schedules_path(base_id: briefing.base_id), notice: "削除が完了しました"
  end

  private

  def briefing_params
  	params.require(:briefing).permit(Schedule::REGISTRABLE_ATTRIBUTES, :mentor, :base_id)
  end
end
