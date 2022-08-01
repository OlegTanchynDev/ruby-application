namespace :gemfile do
  desc "Clean annotations, sort and group gems in Gemfile"
  task clean: :environment do
    print "Do you want clean your Gemfile?(y/n): "
    option = STDIN.gets.strip

    case option
    when /[Yy]/
      sh %{ ruby -pi -pe "gsub(/^#.*.*\n/, '')" Gemfile }

      gems = %x[ sed -n '/gem /{/grep/!p;}' Gemfile ]
      # %q = ''
      # %Q = ""
      # %w = [","]
      # %i = [:aqs,:fss]
      # %x = ``
      # %{ = %q( or any { [
      gems_array = []
      gems.each_line do |gem|
        puts gem
        #gems_array << gem
      end

      group_gems = %x[ sed -n '/  gem /{/grep/!p;}' Gemfile ]
      group_gems_array = []
      group_gems.each_line do |group_gem|
        puts group_gem # Where t is your task name
        #group_gems_array << group_gem
      end

      groups = %x[ sed -n '/group/{/grep/!p;}' Gemfile ]
      groups_array = []
      groups.each_line do |group|
        puts group # Where t is your task name
=begin
       groups_array << group
=end
      end

      all_gems = (gems+groups+group_gems)
      all_gems2 = (gems+groups)

      File.write('Gemfile2', all_gems2)

    else
      abort_message
    end
  end
  def abort_message
    abort("Exiting.")
  end
end
