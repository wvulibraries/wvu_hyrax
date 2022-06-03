class DashboardController < ApplicationController
  include Hydra::Controller::ControllerBehavior

  # JL : 14/02/2019 Put security (admin level) around the ingest screen
  before_action :authenticate_user!
  before_action :ensure_admin!

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def index
  end
end
