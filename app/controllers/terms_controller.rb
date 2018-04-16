class TermsController < ApplicationController

  def index
    @terms = Term.where('term_i < 1000').order('term_i DESC').page(params[:page]).per(10)
  end

  def show
    @term = Term.find(params[:id])
    @students = Student.where(term: @term.term_i).order('family_name_kana ASC').page(params[:page]).per(10)
  end

  def new
    @term = Term.new
  end

  def create
    @term = Term.new(term_params)
    if @term.save
      redirect_to terms_path, notice: "登録が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :new
    end
  end

  def edit
    @term = Term.find(params[:id])
  end

  def update
    @term = Term.find(params[:id])
    if @term.update(term_params)
      redirect_to @term, notice: "変更が完了しました"
    else
      flash.now[:alert] = "必須項目が入力されていません"
      render :edit
    end
  end

  def destroy
    term = Term.find(params[:id])
    term.destroy
    redirect_to terms_path, notice: "削除が完了しました"
  end

  private

  def term_params
    params.require(:term).permit(:term_i, :term_t)
  end
  
end
