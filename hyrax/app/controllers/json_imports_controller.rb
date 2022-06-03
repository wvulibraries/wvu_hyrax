# frozen_string_literal: true

class JsonImportsController < ApplicationController
  with_themed_layout 'dashboard'

  def index; end

  def show; end

  def new; end

  # Validate the JSON file and display errors or
  # warnings to the user.
  def preview; end

  def create; end

  def log
    log_file = Rails.root.join('log', "ingest_#{params[:id]}.log")
    log_text = if File.exist?(log_file)
                 File.open(log_file).read
               else
                 'Could not read a log file for this import'
               end
    render plain: log_text
  end

  def service
  end

  private

    def load_and_authorize_preview
    end

    def create_params; end

    def preserve_cache; end

    def row_times; end

    def min; end

    def max; end

    def mean; end

    def median; end

    def std_deviation; end
end
