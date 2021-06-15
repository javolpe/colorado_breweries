class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

  def render_invalid_record_response(exception)
    render json: exception.record.errors, status: 404
  end

  def render_record_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def page 
    params[:page].to_i < 1 ? @page = 1 : @page = params[:page].to_i  
  end
  
  def per_page 
    params[:per_page].to_i < 1 ? @per_page = 20 : @per_page = params[:per_page].to_i
  end

  def paginated_response(serializer, objects)
    serializer.new(objects.limit(per_page))
  end
end
