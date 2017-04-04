class ApplicationController < ActionController::Base
  protect_from_forgery
  WillPaginate.per_page = 20

  def flash_message(model_name, status=true)

    info = {
      false => {create: "creation", update: "updation", destroy: "deletion"},
      true => {create: "created", update: "updated", destroy: "deleted"}
    }
    type = info[status][params[:action].to_sym]
    if status
    flash.now[:success] = "#{model_name} was successfully #{type}"
    else

      flash.now["alert-danger"] = "#{model_name} #{type} failed"
    end
  end
end
