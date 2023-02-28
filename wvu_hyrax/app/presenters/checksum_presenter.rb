class ChecksumPresenter

  def audited
    Checksum.where(:last_fixity_result => ["PASS", "FAIL"]).count
  end

  def failed
    Checksum.where(:last_fixity_result => "FAIL").count
  end

  def all
    Checksum.count
  end

end
