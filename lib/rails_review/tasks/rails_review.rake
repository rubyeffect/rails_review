namespace :rails_review do
  desc "Task to initiate the rails style guide checks"
  task :start do
    RailsReview::start
  end
end
