namespace :gemfile3 do
  desc "Clean annotations, sort and group gems in Gemfile"
  task clean: :environment do
    gems_hash = ::Hash.new { |h, k| h[k] = [] }
    ruby_hash = ::Hash.new { |h, k| h[k] = [] }
    source_hash = ::Hash.new { |h, k| h[k] = [] }
    git_source_hash = ::Hash.new { |h, k| h[k] = [] }

    ::File.open('Gemfile') do |file|
      key = :without_group

      until file.eof?
        line = file.readline.rstrip

        case line
        when /\A\s*group/
          key = ("\n") << line
          gems_hash[key] ||= []
        when /\A\s*gem/
          gems_hash[key] << line
        when /\A\s*end/
          gems_hash[key] << line ? line : "hey"
          key = :without_group
        when /\A\s*ruby/
          ruby_hash[:ruby] << line << ("\n")
        when /\A\s*source/
          source_hash[:source] << line << ("\n")
        when /\A\s*git_source/
          git_source_hash[:git_source] << line << ("\n")
        end
      end
      def replace_gemfile(source_hash, git_source_hash, ruby_hash, gems_hash)
        source_hash = source_hash.to_a.join("\n")
        git_source_hash = git_source_hash.to_a.join("\n")
        ruby_hash = ruby_hash.to_a.join("\n")
        gems_hash = gems_hash.to_a.map{|group, gems| [group,gems.sort]}.join("\n")

        hash = (source_hash + git_source_hash + ruby_hash + gems_hash)
        hash = hash.remove("without_group\n","\nruby\n","\ngit_source\n","source\n","end\nend\n")
        File.open("Gemfile", 'w') { |file| file.write(hash) }
      end
      replace_gemfile(source_hash, git_source_hash, ruby_hash, gems_hash)
    end
  end
end
