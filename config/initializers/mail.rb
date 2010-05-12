ActionMailer::Base.delivery_method = :smtp  
ActionMailer::Base.smtp_settings = {  
  :address => "localhost",  
  :port => 25,  
  :domain => "www.coursecrawler.com",  
  :authentication => :login,  
  :user_name => "coursecrawler",  
  :password => "v^iv$XqP"  
}

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_charset = 'utf-8'
