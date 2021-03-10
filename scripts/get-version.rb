#!/usr/bin/env ruby

def get_build_number(prefix)
    # fetch all tags
    `git fetch --all --tags &> /dev/null`
    
    # get latest number with our prefix
    version = `git tag -l --sort=-v:refname #{prefix}* | head -n 1 | awk '{ split($0, a, "/"); print a[2]}'`.to_i
    
    loop do
      loop do
        version += 1
        # try to add a new tag with a new build number
        `git tag #{prefix}/#{version} &> /dev/null`
        break if $?.success?
      end
      # try to push the new tag
      `git push origin #{prefix}/#{version} &> /dev/null`
      
      pushed = $?.success?
      # remove the conflicting tag if push failed
      `git tag -d #{prefix}/#{version} &> /dev/null` unless pushed
      break if pushed
    end

    return version
end

puts get_build_number('build-no')
