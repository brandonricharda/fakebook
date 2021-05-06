class UserMailer < ApplicationMailer
    default from: "brandonricharda@gmail.com"

    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Welcome to Fakebook!")
    end
end
