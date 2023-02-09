class FixityAuditMailer < ApplicationMailer
  default from: 'noreply@mail.wvu.edu'

  def fixity_audit_email(week_no)
    @week_no = week_no
    mail(to: 'tam0013@mail.wvu.edu,Steve.Giessler@mail.wvu.edu,jessica.mcmillen@mail.wvu.edu,twilli23@mail.wvu.edu,jagriffis@mail.wvu.edu,elizabeth.james1@mail.wvu.edu', subject: 'Digital Collections Fixity Audit')
  end
end