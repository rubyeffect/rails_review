module RailsReview
  class Checker
    @@errors = {}
    class << self

      # Method to check whether Gemfile.lock is present in .gitignore or not
      def gemlock_check
        File.foreach('.gitignore').with_index do |line, index|
          if line.include? 'Gemfile.lock'
            @@errors["/.gitignore"] = [{:gemlock => index + 1}]
            break
          end
        end
      end

      # Method to check if timezone has been configured
      def timezone_check
        line_num = 0
        config_line  = ''
        File.foreach("#{Rails.root}/config/application.rb").with_index do |line, index |
          if line.include? "config.time_zone"
            line_num = index + 1
            config_line = line
          end
          break if line_num != 0
        end
        formatted_config_line = config_line.gsub(' ', '')
        if formatted_config_line.first == '#' || formatted_config_line.length == 19
          @@errors["/config/application.rb"] = [{:timezone => line_num}]
        end
      end

      # Method to check if separate directory is being used for custom validators
      def custom_validator_directory_check
        if Dir["#{Rails.root}/app/validators"].empty?
          @@errors["/validators"] = [{:validators => "not found"}]
        end
      end

      def app_directory_check
        files = Dir.glob(File.join(["#{Rails.root}/app", '**', '*'])).reject { |f| File.directory?(f) || f.include?("/assets/") }

        files.each do |file|
          File.foreach(file).with_index do |line, index|
            @@errors[file] = [] unless @@errors.has_key?(file)
            @@errors[file] << {:time_now => index + 1} if line.include? 'Time.now'
            @@errors[file] << {:time_parse => index + 1} if line.include? 'Time.parse'

            # Controller Specific Checks
            if file.include?("/controllers/")
              formatted_line = line.gsub(' ', '')
              if formatted_line.include?("render:inline") || formatted_line.include?("renderinline:")
                @@errors[file] << {:render_inline => index + 1}
              end
              if formatted_line.include?("render:text") || formatted_line.include?("rendertext:")
                @@errors[file] << {:render_text => index + 1}
              end
              if formatted_line.include?("render:status") || formatted_line.include?("renderstatus:")
                status = formatted_line.gsub("render:status", '').gsub("renderstatus:", '').first
                @@errors[file] << {:render_status => index + 1} if status =~ /^[-+]?[1-9]([0-9]*)?$/
              end
            end

            # Checks for all sub-directories of app except views
            unless file.include?("/views/")
              @@errors[file] << {:find_by_sql => index + 1} if line.include?("find_by_sql") && !line.include?("<<")
              @@errors[file] << {:update_attribute => index + 1} if line.include?("update_attribute(")
              @@errors[file] << {:dot_all => index + 1} if line.include?(".all")
            end

            # Models specific checks
            if file.include?("/models/")
              @@errors[file] << {:table_name => index + 1} if line.include?("self.table_name")
              @@errors[file] << {:read_attribute => index + 1} if line.include?("read_attribute")
              @@errors[file] << {:write_attribute => index + 1} if line.include?("write_attribute")
              @@errors[file] << {:habtm => index + 1} if line.include?("has_and_belongs_to_many")
              formatted_line = line.gsub(" ", "")
              @@errors[file] << {:prepend_true => index + 1} if !(formatted_line.include?("prepend:true") || formatted_line.include?(":prepend=>true")) && line.include?("before_destroy")
              @@errors[file] << {:dependent_destroy => index + 1} if (line.include?('has_one') || line.include?('has_many')) && !line.include?('dependent')
            end

          end
        end
        print
      end # app_directory_check method end

      # Print errors found
      def print
        puts "The following style guide issues have been found:\n"
        serial_number = 0
        @@errors.each do |filename, errors_list|
          next if errors_list.blank?
          computed_filename = filename.gsub("#{Rails.root}", '')
          puts "#{serial_number + 1}. #{computed_filename}\n"
          serial_number += 1
          errors_list.each_with_index do |error, i|
            puts "\t#{i+1}. #{RailsReview::Error::MAP[error.keys.first]} - line: #{error.values.first}\n"
          end
          puts "\n"
        end
      end

    end # class self end
  end # class Checker end
end # module RailsReview end
