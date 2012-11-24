class ApplicationController < ActionController::Base  
  prepend_view_path 'app/views/mycustomfolder'
  
  rescue_from Exception, :with => :on_error

  def on_error e
    if params[:format] == 'json'
      respond_to do |format|
        format.json {
          render :json => {status: 'error', message: e.message, backtrace: e.backtrace, params: params}, :status => 500
        }
      end

      logger.error "#{e.class} (#{e.message}):\n  #{e.backtrace.join("\n  ")}"
    else
      raise e
    end
  end
end
