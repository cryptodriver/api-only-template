class AccountMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_mailer.vertify.subject
  #
  def vertify(email, code)
    @code = code
    mail(
      subject: "[test]検証コードのご送付: [" + code + "]",
      to: email
    ) do |format|
      format.text
    end
  end

end
