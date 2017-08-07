class MypageController < UserPageController
  def index
    #code
  end
  
  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'メールアドレスを更新しました。'
      redirect_to edit_mypage_path(current_user)
    else
      flash[:danger] = 'メールアドレスの更新に失敗しました。'
      redirect_to edit_mypage_path(current_user)
    end
  end

  private

  def user_params
    params.require(:users).permit(:email)
  end

end
