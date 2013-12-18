require 'toothpick/git'
require 'toothpick/search'
require 'toothpick/errors'
require 'date'

module Toothpick
  module Commands

    TOOTHPICK_HOME  = ENV['HOME'] + "/.toothpick"
    PICK_FILENAME   = Date.today.strftime + ".md"

    def self.init(picks_repo)
      Git.clone_repo(picks_repo, TOOTHPICK_HOME)
    end

    def self.new_pick
      abort_if_setup_not_done!
      git = Git.new(TOOTHPICK_HOME)
      git.update
      pid = Kernel.spawn("$EDITOR #{pick_file_path}")
      Process.waitpid(pid)
      if $?.success? and File.exists?(pick_file_path)
        git.commit
        git.push
      end
    end

    def self.search(string)
      abort_if_setup_not_done!
      Search.new(TOOTHPICK_HOME, string)
    end

    private

      def self.abort_if_setup_not_done!
        unless Git.on_git?(TOOTHPICK_HOME)
          raise Errors::ToothpickNotInitialized,
            "You need to run 'toothpick init' first"
        end
      end

      def self.pick_file_path
        File.join(TOOTHPICK_HOME, PICK_FILENAME)
      end

  end
end
