class InvestorsController < ApplicationController
  before_filter :authenticate_investor! , :only => [:investment_opportunity_detail]
  respond_to :json ,:only => [:index,:destroy,:update_investor]
  def analysis
    @investor = current_investor
  end
  def update_analysis
    @investor = current_investor
    us_citizen = params[:us_citizen]
    uk_citizen = params[:uk_citizen]

    not_us_uk_citizen = params[:not_uk_us_citizen]
    us_tax_purpose = params[:user_name]
    us_provision_term = params[:us_provision_term]
    us_terms_of_service = params[:us_terms_of_service]
    uk_term1 = params[:uk_term1]
    uk_term2 = params[:uk_term2]
    uk_term3 = params[:uk_term3]
    uk_annual_income = params[:uk_annual_income]
    uk_assets_worth = params[:uk_assets_worth]
    if !us_citizen.blank? && !us_tax_purpose.blank? && !us_provision_term.blank? && !us_terms_of_service.blank?
      @investor.update_attributes(:us_citizen => us_citizen,:us_tax_purpose => us_tax_purpose,:us_provision_term=> us_provision_term,:us_terms_of_service => us_terms_of_service)
    elsif !uk_citizen.blank? && !uk_term1.blank? && !uk_term2.blank? && !uk_term3.blank?
      @investor.update_attributes(:uk_citizen => uk_citizen,:uk_term1 => uk_term1,:uk_term2=> uk_term2,:uk_term3 => uk_term3,:uk_annual_income => uk_annual_income, :uk_assets_worth => uk_assets_worth)
    elsif !not_us_uk_citizen.blank?
      @investor.update_attributes(:not_us_uk_citizen => not_us_uk_citizen)
    end

    redirect_to successfull_registration_path
  end

  def successfull_registration
  end

  def mailchimp_registration
    begin
        gb = Gibbon::API.new("5aedadeebc45a448295039f618d5b01d-us7")
        list_id = "8bdc564e99"
        email = params[:email]
        gb.lists.subscribe({:id => list_id, :email => {:email => email},:double_optin => false})
        flash[:notice] = "You are successfully subscribed via your email address - #{email}. Thank you"
      rescue Gibbon::MailChimpError => e
        flash[:error] = e.message 
      end
    respond_to do |format|
      format.js
    end
  end

  def investment_opportunity_detail
    @investment_opportunity = InvestmentOpportunity.find(params[:id])
    @management_teams = @investment_opportunity.teams.where(:team_type => "Management Team")
    @advisory_teams = @investment_opportunity.teams.where(:team_type => "Advisory Team")
    @news_presses = @investment_opportunity.news_presses
    @documents = @investment_opportunity.opportunity_documents
    @presentations = @investment_opportunity.opportunity_presentations
    @presentation_videos = @investment_opportunity.presentation_videos
  end

  def send_investment_email
    @investment_opportunity = InvestmentOpportunity.find(params[:id])
    @investor = current_investor
    UserMailer.investment_email(@investor,@investment_opportunity).deliver
    #redirect_to investment_opportunity_detail_path(@investment_opportunity.id)
    #flash[:notice] = "Your request to invest in this opportunity has been sent successfully to admin. Thank you"
    respond_to do |format|
      format.js
    end
  end

  def index
    @investors = Investor.all
    render :json => {
      :response_status => "200",
      :data => @investors.as_json(:only => [:id,:first_name,:last_name,:email,:confirmed_at,:country])
    }

  end

  def destroy
    investor = Investor.find(params[:investor_id])
    investor.destroy
    render :json => {
      :response_status => "200",
      :message => "Investor deleted successfully"
    }
  end
  def edit
    @investor = current_investor
    respond_to do |format|
      format.html 
    end
  end
  def update
    @investor = current_investor
    if investor_params[:password].blank?
      investor_params.delete("password")
      investor_params.delete("password_confirmation")
    end
    @investor.update(investor_params)

    respond_to do |format|
      format.html do
        if @investor.valid?
          flash[:notice] = "Profile updated successfully"
          render "edit"
        else
          render "edit"
        end
      end
    end  
  end
  def edit_investor
    investor = Investor.find(params[:investor_id])
    render :json => {
      :response_status => "200",
      :data => investor
    }
  end
  def update_investor
    investor = Investor.find_by_id(params[:investor_id]) 
   
    if investor.blank?
       render :json=>{
              :response_status => "404",
              :message=>"Investor not found"
            }
    else 
      
      email = params[:email] || investor.email
      first_name = params[:first_name] || investor.first_name
      last_name = params[:last_name] || investor.last_name
      country = params[:country] || investor.country
      
     
      investor.update_attributes(:email=>email,:first_name=>first_name,:last_name => last_name,:country => country)
      if investor.save
        render :json=>{
                :response_status => "200",
                :message=> "Investor details updated successfully"
                }
      else
        render :json=>{
                :response_status => "500",
                :message=> investor.errors.full_messages.join(" , ")
                }        
              
      end
    end  
  end

  private
    def investor_params
      params.require(:investor).permit!
    end
end
