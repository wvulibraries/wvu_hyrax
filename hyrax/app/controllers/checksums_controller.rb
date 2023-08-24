class ChecksumsController < ApplicationController

  include Hyrax::ThemedLayoutController

  # JL : 14/02/2019 Put security (admin level) around the ingest screen
  before_action :authenticate_user!
  before_action :ensure_admin!

  with_themed_layout 'dashboard'

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def index
    add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
    add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
    add_breadcrumb 'Checksum Audits', checksums_path
    @checksums = Checksum.all
  end

  def create
  end

  def update
  end

  private
  def checksum_params
    params.require(:checksum).permit(:last_fixity_result, :last_fixity_check)
  end

end
