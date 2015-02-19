class SessionsController < Devise::SessionsController
	def create
      self.resource = warden.authenticate!(auth_options)
      if params[:investor][:remember_me].to_s == "1"
        userId = self.resource.id.to_s
        cookies[:remember_me_id] = { :value => userId, :expires => 30.days.from_now }
        userCode = Digest::SHA1.hexdigest(self.resource.email)[4,18]
        cookies[:remember_me_pass] = {:value => params[:investor][:password],  :expires => 10.days.from_now}
        cookies[:remember_me_code] = {:value =>userCode, :expires => 10.days.from_now}
      else  
        cookies.delete :remember_me_pass
        cookies.delete :remember_me_code
        cookies.delete :remember_me_id  
      end  
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      session[:investor_id] = self.resource.id 
     
      if !session[:return_to].blank?
        redirect_to session[:return_to]
        session[:return_to] = nil
      else
        respond_with resource, :location => after_sign_in_path_for(resource)
      end
      # params[:user].merge!(remember_me: 1)
      
    end
end