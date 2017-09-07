module ControllerResponder
  def save_and_respond(object, notice: nil, redirect: object)
    saved = object.save
    respond(object, saved, notice: notice, redirect: redirect)
  end

  def respond(object, saved, notice: nil, redirect: object)
    respond_to do |format|
      if saved
        format.html { redirect_to redirect, notice: notice }
        format.json { render :show, status: :created, location: redirect }
      else
        format.html { render(object.new_record? ? :new : :edit) }
        format.json { render json: object.errors.as_json.merge(messages: object.errors.full_messages.join("\n")), status: :unprocessable_entity }
      end
    end
  end
end