class FixityAuditMailer < ApplicationMailer
  default from: 'libdev@mail.wvu.edu'

  def fixity_audit_email(week_no)
    @week_no = week_no
    mail(to: 'libdev@mail.wvu.edu', subject: 'Digital Repository Fixity Audit')
  end
end
