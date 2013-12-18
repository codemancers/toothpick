module Toothpick
  class Git

    attr_reader :git_dir

    def self.clone_repo(repo, target_dir)
      system("git clone #{repo} #{target_dir}")
    end

    def self.on_git?(dir)
      return system("cd #{dir} && git rev-parse --git-dir")
    end

    def initialize(git_dir)
      @git_dir = git_dir
    end

    def update
      system("cd #{git_dir} && git pull --rebase")
    end

    def commit
      system("cd #{git_dir} "\
        "&& git add --all "\
        "&& git commit --allow-empty-message -m ''")
    end

    def push
      system("cd #{git_dir} && git push origin master")
    end

  end
end
