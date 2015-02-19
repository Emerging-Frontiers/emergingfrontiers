class HomeController < ApplicationController
  #require 'nokogiri'
    require 'rss'
    require 'open-uri'
  def index
    @investment_opportunities = InvestmentOpportunity.order("created_at asc")
    @home = StaticPage.where("title = (?)","Home").first
  end

  def blogs
  	@blogs = Blog.where(:published => true).order("created_at desc")
  end

  def investment
   @investment_opportunities = InvestmentOpportunity.order("created_at asc")
    @selection_criteria = StaticPage.where("title = (?)","Selection Criteria").first
  end

  def about
    @about = StaticPage.where("title = (?)","About").first
    logger.info ">>>>>>>>#{@about.id}"
  end

  def approach 
    @approach = StaticPage.where("title = (?)","Approach").first
  end

  def legal
    @legal = StaticPage.where("title = (?)","Legal").first
  end

  def blog_detail
  	@blog = Blog.find(params[:id])

   # html_text = @blog.description

   #  @frag = Nokogiri::HTML(html_text)
   #    @frag.xpath("//em").each { |tag|  tag.name= "i";  }
  end

  def read_rss_feed
    url = 'http://www.pathfinder.vc/feed/'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      puts "Title: #{feed.channel.title}"
      feed.items.each do |item|
        puts "Item: #{item.title}"
        puts "Link: #{item.link}"
      end
    end
  end

  def send_to_mailchimp
    begin
      gb = Gibbon::API.new("5aedadeebc45a448295039f618d5b01d-us7")
      list_id = "243db8f0ef"
      first_name = params[:first_name]
      last_name = params[:last_name]
      email = params[:email]
      comment = params[:comment]
      gb.lists.subscribe({:id => list_id, :email => {:email => email}, :merge_vars => {:FNAME => first_name, :LNAME => last_name, :COMMENTS => comment}, :double_optin => false})
      redirect_to root_url(anchor: "sec5-con")
      flash[:notice] = "You are successfully subscribed via your email address - #{email}. Thank you"
    rescue Gibbon::MailChimpError => e
      redirect_to root_url(anchor: "sec5-con")
      flash[:error] = e.message 
    end
  end

  def contact_us
    name = params[:full_name]
    subject = params[:subject]
    message = params[:message]
    email = params[:email]

    UserMailer.contact_us_email(email,name,subject,message).deliver
    redirect_to about_path(anchor: "sec4")
    flash[:notice] = "Email successfully sent. Thank you"
  end

  
end
