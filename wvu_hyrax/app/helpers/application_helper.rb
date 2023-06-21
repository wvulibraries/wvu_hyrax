module ApplicationHelper
    def application_header
        'WVU Digital Repository'
    end    

    def active_for_controller controller_name
        params[:controller] == controller_name.to_s ? 'active' : ''
    end
end
