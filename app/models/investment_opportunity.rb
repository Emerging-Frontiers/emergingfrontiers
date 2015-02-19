class InvestmentOpportunity < ActiveRecord::Base
  has_many :opportunity_documents
    has_many :teams
    accepts_nested_attributes_for :teams
    
    has_many :news_presses
    accepts_nested_attributes_for :news_presses
 
   has_many :opportunity_presentations

    has_many :presentation_videos
    accepts_nested_attributes_for :presentation_videos

  
end
