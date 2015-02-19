class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    build_resource(sign_up_params)
    if resource.save
      if params[:mailchimp_reg] == "on"
        begin
          gb = Gibbon::API.new("5aedadeebc45a448295039f618d5b01d-us7")
          list_id = "243db8f0ef"
          first_name = resource.first_name
          email = resource.email
          gb.lists.subscribe({:id => list_id, :email => {:email => email}, :merge_vars => {:FNAME => first_name}, :double_optin => false})
          flash[:notice] = "You are successfully subscribed via your email address - #{email}. Thank you"
        rescue Gibbon::MailChimpError => e
          flash[:error] = e.message 
        end
      end
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  
end 