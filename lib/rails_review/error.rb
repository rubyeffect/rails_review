module RailsReview
  class Error

    # Mapping symbols to respective description of rails style guide.
    MAP = {
      :gemlock => "Do not remove the Gemfile.lock from version control. This is not some randomly generated file - it makes sure that all of your team members get the same gem versions when they do a bundle install",
      :timezone => "Config your timezone accordingly in application.rb",
      :validators => "Keep custom validators under app/validators",
      :time_now => "Don't use Time.now. Use Time.zone.now or Time.current instead",
      :time_parse => "Don't use Time.parse. Use Time.zone.parse instead",
      :render_inline => "Prefer using a template over inline rendering",
      :render_text => "Prefer render plain: over render text:",
      :render_status => "Prefer corresponding symbols to numeric HTTP status codes. They are meaningful and do not look like 'magic' numbers for less known HTTP status codes.",
      :find_by_sql => "When specifying an explicit query in a method such as find_by_sql, use heredocs with squish. This allows you to legibly format the SQL with line breaks and indentations, while supporting syntax highlighting in many tools (including GitHub, Atom, and RubyMine).",
      :update_attribute => "Beware of the behavior of the update_attribute method. It doesn't run the model validations (unlike update_attributes) and could easily corrupt the model state.",
      :dot_all => "Use find_each to iterate over a collection of AR objects. Looping through a collection of records from the database (using the all method, for example) is very inefficient since it will try to instantiate all the objects at once. In that case, batch processing methods allow you to work with the records in batches, thereby greatly reducing memory consumption.",
      :table_name => "Avoid altering ActiveRecord defaults (table names, primary key, etc) unless you have a very good reason (like a database that's not under your control).",
      :read_attribute => "Prefer self[:attribute] over read_attribute(:attribute)",
      :write_attribute => "Prefer self[:attribute] = value over write_attribute(:attribute, value)",
      :habtm => "Prefer has_many :through to has_and_belongs_to_many. Using has_many :through allows additional attributes and validations on the join model.",
      :prepend_true => "Since Rails creates callbacks for dependent associations, always call before_destroy callbacks that perform validation with prepend: true",
      :dependent_destroy => "Define the dependent option to the has_many and has_one associations."
    }
  end
end
