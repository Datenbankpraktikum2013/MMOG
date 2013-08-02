class Users::RegistrationsController < Devise::RegistrationsController

  #init UserSettings
  def create
    super
    user = User.last
    UserSetting.create(:user => user)

  end


end
