class OmniauthCallbacksController < Devise::OmniauthCallbacksController   
  def linkedin
    auth = env["omniauth.auth"]
    @investor = Investor.connect_to_linkedin(request.env["omniauth.auth"],current_investor)
    if @investor.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      begin
        gb = Gibbon::API.new("5aedadeebc45a448295039f618d5b01d-us7")
        list_id = "243db8f0ef"
        first_name = @investor.first_name
        email = @investor.email
        gb.lists.subscribe({:id => list_id, :email => {:email => email}, :merge_vars => {:FNAME => first_name}, :double_optin => false})
        flash[:notice] = "You are successfully subscribed via your email address - #{email}. Thank you"
      rescue Gibbon::MailChimpError => e
        flash[:error] = e.message 
      end
      sign_in_and_redirect @investor, :event => :authentication
    else
      session["devise.linkedin_uid"] = request.env["omniauth.auth"]
      redirect_to new_investor_registration_url
    end
  end  
  def angellist
    auth = env["omniauth.auth"]
    @investor = Investor.connect_to_angellist(request.env["omniauth.auth"],current_investor)
    if @investor.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success"
      begin
        gb = Gibbon::API.new("5aedadeebc45a448295039f618d5b01d-us7")
        list_id = "243db8f0ef"
        first_name = @investor.first_name
        email = @investor.email
        gb.lists.subscribe({:id => list_id, :email => {:email => email}, :merge_vars => {:FNAME => first_name}, :double_optin => false})
        flash[:notice] = "You are successfully subscribed via your email address - #{email}. Thank you"
      rescue Gibbon::MailChimpError => e
        flash[:error] = e.message 
      end
      sign_in_and_redirect @investor, :event => :authentication
    else
      session["devise.angllist_uid"] = request.env["omniauth.auth"]
      redirect_to new_investor_registration_url
    end
  end  
end