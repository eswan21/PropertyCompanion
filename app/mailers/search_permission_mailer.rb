class SearchPermissionMailer < ApplicationMailer
  def access_granted(search_permission)
    @search = search_permission.search
    @user = search_permission.user

    mail(
      to: @user.email,
      subject: "You have access to a shared search"
    )
  end
end
